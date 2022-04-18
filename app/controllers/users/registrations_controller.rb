class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  before_action :is_valid?

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: 500
    end
  end

  private

  def user_params
    params.require([:email, :password, :first_name, :last_name])
    params.permit(:email, :password, :first_name, :last_name)
  end
end
