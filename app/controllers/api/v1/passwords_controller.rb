class Api::V1::PasswordsController < ApplicationController
  before_action :set_user
  before_action :require_same_user
  after_action :refresh_jwt

  rescue_from ActiveRecord::RecordNotFound do
    render_json_error :not_found, :user_not_found
  end

  def update
    if @user.reset_password!(update_password_params[:password])
      render json: { message: 'Password sucessfully changed.' }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    token, = token_and_options(request)
    payload = AuthTokenService.decode_jwt(token)
    user_id = payload ? payload[0]['user_id'] : nil
    @user = User.find(user_id)
  end

  def update_password_params
    params.require(:password).permit(:password)
  end

  def require_same_user
    unauthorized! unless @current_user == @user
  end
end
