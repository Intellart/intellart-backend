class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate_api_user!, only: [:create_session, :create_user, :make_confirmation_url]
  after_action :make_header_jwt, only: [:create_session]

  rescue_from ActiveRecord::RecordNotFound do
    render_json_error :not_found, :user_not_found
  end

  rescue_from JWT::VerificationError, JWT::DecodeError, with: unauthorized!

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

  # POST /api/auth/user
  def create_user
    @user = User.new(user_create_params)
    render_json_validation_error(@user) and return unless @user.save

    render json: @user, status: :ok
  end

  # DELETE /api/auth/session
  def destroy_session
    token, = token_and_options(request)
    AuthTokenService.save_expired_token(token)
    head :no_content
  end

  # POST /api/auth/validate_jwt
  def validate_jwt
    token = params[:jwt]
    jwt_payload = AuthTokenService.decode_jwt(token)
    user_id = jwt_payload[0]['user_id']
    user = User.find(user_id)
    unauthorized! and return unless user == @current_user && !jwt_expired?(token)

    head :ok
  end

  private

  def user_session_params
    params.require(:user).permit(:email, :password)
  end

  def user_create_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :study_field_id, :orcid_id)
  end
end
