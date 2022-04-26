class Api::V1::UsersController < ApplicationController
  before_action :set_user
  before_action :require_same_user, only: [:update, :destroy]
  after_action :refresh_jwt

  rescue_from ActiveRecord::RecordNotFound do
    render_json_error :not_found, :user_not_found
  end
  rescue_from ActiveRecord::RecordNotDestroyed do
    render_json_error :not_destroyed, :user_not_destroyed
  end

  # GET /api/v1/users/:id
  def show
    render json: { data: @user }, status: :ok
  end

  # PUT/PATCH /api/v1/users/:id
  def update
    render_json_validation_error(@user) and return unless @user.update(user_update_params)

    render json: { data: @user }, status: :ok
  end

  # DELETE /api/v1/users/:id
  def destroy
    head :no_content if @user.destroy
  end

  private

  def require_same_user
    head :unauthorized unless @current_user == @user
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_update_params
    params.require(:user).permit(:first_name, :last_name, :orcid_id, :study_field_id)
  end
end
