class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate_api_user!, only: [:create_session, :create_user]

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

  # POST /api/auth/user
  def create_user
    @user = User.new(user_create_params)
    render_json_validation_error(@user) and return unless @user.save

    jwt = AuthTokenService.generate_jwt(@user.id)
    render json: { user: @user, _jwt: jwt }, status: :ok
  end

  # DELETE /api/auth/session
  def destroy_session
    token, = token_and_options(request)
    AuthTokenService.save_expired_token(token)
    head :no_content
  end

  private

  def user_session_params
    params.require(:user).permit(:email, :password)
  end

  def user_create_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :study_field_id, :orcid_id)
  end
end
