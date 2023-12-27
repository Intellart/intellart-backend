module Api
  module V1
    module Intellart
      class UsersController < ApplicationController
        before_action :set_user, except: [:index]
        before_action :require_same_user, only: [:update, :destroy]
        before_action :authenticate_api_admin!, only: [:index]
        after_action :refresh_jwt, except: [:show, :index]
        skip_before_action :authenticate_api_user!, only: [:index, :show]

        rescue_from ActiveRecord::RecordNotFound do
          render_json_error :not_found, :user_not_found
        end
        rescue_from ActiveRecord::RecordNotDestroyed do
          render_json_error :not_destroyed, :user_not_destroyed
        end

        # GET /api/v1/users/:id
        def show
          render json: @user, status: :ok
        end

        # GET /api/v1/users
        def index
          users = User.all
          render json: users, status: :ok
        end

        # GET /api/v1/reviewers
        def reviewers
          reviewers = User.where.not(wallet_address: nil)
          render json: reviewers, status: :ok
        end

        # PUT/PATCH /api/v1/users/:id
        def update
          render_json_validation_error(@user) and return unless @user.update(user_update_params)

          render json: @user, status: :ok
        end

        # DELETE /api/v1/users/:id
        def destroy
          head :no_content if @user.destroy
        end

        private

        def require_same_user
          unauthorized! unless @current_user == @user
        end

        def set_user
          @user = User.find(params[:id])
        end

        def user_update_params
          params.require(:user).permit(:first_name, :last_name, :orcid_id, :study_field_id, :profile_img,
                                       :social_web, :social_ln, :social_fb, :social_tw, :username, :bio, :wallet_address)
        end
      end
    end
  end
end
