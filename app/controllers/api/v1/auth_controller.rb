class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate_api_user!, only: [:create_session, :create_user]

  # POST /api/auth/session
  def create_session
    @user = User.find_by_email(user_session_params[:email])
    if @user&.valid_password?(user_session_params[:password])
      jwt = AuthTokenService.generate_jwt(@user.id)
      render json: { user: @user, _jwt: jwt }, status: :ok
    else
      render json: { errors: ['User not found'] }, status: :not_found
    end
  end

  # POST /api/auth/user
  def create_user
    @user = User.new(user_create_params)
    if @user.save
      jwt = AuthTokenService.generate_jwt(@user.id)
      render json: { user: @user, _jwt: jwt }, status: :ok
    else
      render json: @user.errors, status: 500
    end
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
