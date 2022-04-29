class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate_api_user!, only: [:create_session, :create_user, :create_session_orcid, :create_user_orcid, :auth_orcid]

  ORCID_CLIENT_ID = ENV.fetch('ORCID_CLIENT_ID')
  ORCID_SECRET = ENV.fetch('ORCID_SECRET')
  ORCID_API_ENDPOINT = Rails.env.development? ? 'sandbox.' : ''

  # ORCID OAuth API client config
  class OrcidOAuthApi
    include HTTParty
    base_uri "https://#{ORCID_API_ENDPOINT}orcid.org"
  end

  # ORCID API client config
  class OrcidApi
    include HTTParty
    base_uri "https://pub.#{ORCID_API_ENDPOINT}orcid.org/v3.0"
  end

  # POST /api/auth/session
  def create_session
    @user = User.find_by_email(user_session_params[:email])
    if @user.nil?
      render_json_error :not_found, :user_not_found
    elsif @user&.valid_password?(user_session_params[:password])
      jwt = AuthTokenService.generate_jwt(@user.id)
      render json: { user: @user, _jwt: jwt }, status: :ok
    else
      render json: { errors: ['Invalid password.'] }, status: :unprocessable_entity
    end
  end

  # POST /api/auth/session/orcid
  def create_session_orcid
    @user = User.find_by_orcid_id(user_orcid_params[:orcid])
    if @user.nil?
      render_json_error :not_found, :user_not_found
    elsif @user
      jwt = AuthTokenService.generate_jwt(@user.id)
      render json: { user: @user, _jwt: jwt }, status: :ok
    else
      render json: { errors: ['Invalid ORCID Id.'] }, status: :unprocessable_entity
    end
  end

  # POST /api/auth/user
  def create_user
    @user = User.new(user_create_params)
    render_json_validation_error(@user) and return unless @user.save

    jwt = AuthTokenService.generate_jwt(@user.id)
    render json: { user: @user, _jwt: jwt }, status: :ok
  end

  # POST /api/auth/user/orcid
  def create_user_orcid
    response = OrcidApi.get("/#{user_orcid_params[:orcid]}/record", headers: {
                              "Authorization": "Bearer #{user_orcid_params[:access_token]}",
                              "Content-Type": 'application/orcid+json'
                            }).parsed_response

    if !response.nil? && response['error']
      render json: { errors: [response['error_description']] }, status: :bad_request
    elsif !response.nil? && !response['error']
      render json: { user: JSON.parse(response) }, status: :ok
    end
  end

  # POST /api/auth/orcid
  def auth_orcid
    response = OrcidOAuthApi.post('/oauth/token', {
                                    body: {
                                      client_id: ORCID_CLIENT_ID,
                                      client_secret: ORCID_SECRET,
                                      grant_type: 'authorization_code',
                                      redirect_uri: auth_orcid_params[:redirect_uri],
                                      code: auth_orcid_params[:code]
                                    }
                                  }).parsed_response

    if !response.nil? && response['error']
      render json: { errors: [response['error_description']] }, status: :bad_request
    elsif !response.nil? && response['orcid']
      render json: { orcid: response }, status: :ok
    end
  end

  # DELETE /api/auth/session
  def destroy_session
    token, = token_and_options(request)
    AuthTokenService.save_expired_token(token)
    head :no_content, status: :ok
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
