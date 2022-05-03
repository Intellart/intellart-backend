class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate_api_user!, only: [:create_session, :create_user, :create_session_orcid, :create_user_orcid, :auth_orcid]
  after_action :make_header_jwt, only: [:create_session, :create_session_orcid]

  rescue_from ActiveRecord::RecordNotFound do
    render_json_error :not_found, :user_not_found
  end

  ORCID_CLIENT_ID = ENV.fetch('ORCID_CLIENT_ID')
  ORCID_SECRET = ENV.fetch('ORCID_SECRET')

  # POST /api/auth/session
  def create_session
    @user = User.find_by_email(user_session_params[:email])
    render_json_error :not_found, :user_not_found and return unless @user

    if @user&.valid_password?(user_session_params[:password])
      @jwt = AuthTokenService.generate_jwt(@user.id)
      render json: @user, status: :ok
    else
      render json: { errors: ['Invalid password.'] }, status: :unprocessable_entity
    end
  end

  # POST /api/auth/session/orcid
  def create_session_orcid
    @user = User.find_by_orcid_id(user_orcid_params[:orcid])
    render_json_error :not_found, :user_not_found and return unless @user

    @jwt = AuthTokenService.generate_jwt(@user.id)
    render json: @user, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Invalid ORCID Id.'] }, status: :unprocessable_entity
  end

  # POST /api/auth/user
  def create_user
    @user = User.new(user_create_params)
    render_json_validation_error(@user) and return unless @user.save

    render json: @user, status: :ok
  end

  # POST /api/auth/user/orcid
  def create_user_orcid
    response = OrcidService::OrcidApi.get(
      "/#{user_orcid_params[:orcid]}/record",
      headers: {
        "Authorization": "Bearer #{user_orcid_params[:access_token]}",
        "Content-Type": 'application/orcid+json'
      }
    ).parsed_response

    return unless response

    render json: JSON.parse(response), status: :ok and return unless response['error']

    render json: { errors: [response['error_description']] }, status: :bad_request
  end

  # POST /api/auth/orcid
  def auth_orcid
    response = OrcidService::OrcidOAuthApi.post(
      '/oauth/token',
      body: {
        client_id: ORCID_CLIENT_ID,
        client_secret: ORCID_SECRET,
        grant_type: 'authorization_code',
        redirect_uri: auth_orcid_params[:redirect_uri],
        code: auth_orcid_params[:code]
      }
    ).parsed_response

    return unless response

    render json: { orcid: response }, status: :ok and return if response['orcid'] && !response['error']

    render json: { errors: [response['error_description']] }, status: :bad_request
  end

  # DELETE /api/auth/session
  def destroy_session
    token, = token_and_options(request)
    AuthTokenService.save_expired_token(token)
    head :no_content, status: :ok
  end

  # POST /api/auth/validate_jwt
  def validate_jwt
    token = params[:jwt]
    jwt_payload = AuthTokenService.decode_jwt(token)
    user_id = jwt_payload[0]['user_id']
    user = User.find(user_id)
    head :unauthorized and return unless user == @current_user && !jwt_expired?(token)
  rescue JWT::VerificationError, JWT::DecodeError
    head :unauthorized and return

    head :ok
  end

  private

  def user_session_params
    params.require(:user).permit(:email, :password)
  end

  def user_create_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :study_field_id, :orcid_id)
  end

  def auth_orcid_params
    params.require(:orcid).permit(:code, :redirect_uri)
  end

  def user_orcid_params
    params.require(:orcid).permit(:access_token, :token_type, :refresh_token, :expires_in, :scope, :name, :orcid)
  end
end
