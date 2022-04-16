class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  before_action :is_valid?

  def create
    @user = User.find_by_email(user_params[:email])
    if @user && @user.valid_password?(user_params[:password])
      render json: { status: 200, data: @user }
    else
      render json: { status: 500, errors: ['User not found'] }
    end
  end

  private

  def user_params
    params.require([:email, :password])
    params.permit(:email, :password)
  end
end
