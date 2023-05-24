module Api
  module V1
    module Pubweave
      class CommentsController < ApplicationController
        before_action :set_comment, only: [:show, :update, :destroy, :like, :dislike]
        before_action :authenticate_api_user!, except: [:index, :show]
        after_action :refresh_jwt, only: [:create, :update, :destroy]
        before_action :require_owner, only: [:update, :destroy]
        before_action :authenticate_domain, except: [:index, :show]

        rescue_from ActiveRecord::RecordNotFound do
          render_json_error :not_found, :comment_not_found
        end

        # POST api/v1/pubweave/comments/
        def create
          @comment = Comment.new(comment_params)
          render_json_validation_error(@comment) and return unless @comment.save

          render json: @comment, status: :created
        end

        # PUT/PATCH api/v1/pubweave/comments/:id
        def update
          render_json_validation_error(@comment) and return unless @comment.update(comment_update_params)

          render json: @comment, status: :ok
        end

        # POST api/v1/pubweave/comments/:id/like/
        def like
          comment.rate!(@current_user, :like)
          render json: @comment, status: :ok
        rescue StandardError
          render json: @comment.errors, status: :unprocessable_entity
        end

        # POST api/v1/pubweave/comments/:id/dislike/
        def dislike
          comment.rate!(@current_user, :dislike)
          render json: @comment, status: :ok
        rescue StandardError
          render json: @comment.errors, status: :unprocessable_entity
        end

        # DELETE api/v1/pubweave/comments/:id
        def destroy
          render json: @comment.id, status: :ok if @comment.destroy
        end

        private

        def require_owner
          head :unauthorized unless @current_user.id == @comment.commenter_id
        end

        def set_comment
          @comment = Comment.find(params[:id])
        end

        def comment_params
          params.require(:comment).permit(:article_id, :commenter_id, :comment, :reply_to_id)
        end

        def comment_update_params
          params.require(:comment).permit(:comment)
        end
      end
    end
  end
end
