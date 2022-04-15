class UsersController < ApplicationController
  # before_action :authorize!
  # before_action :is_valid?
  # before_action :authenticate_super_admin!#, only: [:create]
  # before_action :set_user, only: [:show, :destroy]
  layout 'admin'

  def index
    @users = User.all
    respond_to do |format|
      if @users
        format.html { @users }
        format.json { render json: @users }
      else
        format.html { redirect_to new_user_registration_path, notice: 'No users found, please register first.' }
        format.json { render json: { status: 500, errors: ['no users found'] } }
      end
    end
  end

  def show
    respond_to do |format|
      @user = User.find(params[:id])
      if @user
        format.html { @user }
        format.json { render json: @user }
      else
        format.html { redirect_to users_path, notice: 'User not found.' }
        format.json { render json: { status: 500, errors: ['user not found'] } }
      end
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
