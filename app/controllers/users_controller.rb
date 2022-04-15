class UsersController < ApplicationController
  # before_action :authorize!
  before_action :is_valid?
  # before_action :authenticate_super_admin!#, only: [:create]
  # before_action :set_user, only: [:show, :destroy]

  def show
    @user = User.find_by_email(params[:email])
    if @user
      render json: @user
    else
      render json: { status: 500, errors: ['user not found'] }
    end
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        login_user!
        format.html { @user }
        format.json { render json: { status: :created, user: @user } }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { status: 500, errors: @user.errors.full_messages } }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    return unless @user.destroy

    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
