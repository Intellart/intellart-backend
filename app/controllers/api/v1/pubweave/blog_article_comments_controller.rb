module Api
  module V1
    module Pubweave
      class BlogArticleCommentsController < ApplicationController
        before_action :set_comment, only: [:show, :update, :destroy]
        before_action :authenticate_api_user!, except: [:index, :show]
        after_action :refresh_jwt, only: [:create, :update, :destroy]

        rescue_from ActiveRecord::RecordNotFound do
          render_json_error :not_found, :blog_article_comment_not_found
        end

        def index
          comments = BlogArticleComment.all
          render json: comments, status: :ok
        end

        def show
          render json: @comment, status: :ok
        end

        # POST api/v1/pubweave/blog_article_comments/
        def create
          @article = BlogArticleComment.new(comment_params)
          render_json_validation_error(@comment) and return unless @comment.save

          render json: @article, status: :created
        end

        # PUT/PATCH api/v1/pubweave/blog_article_comments/:id
        def update
          render_json_validation_error(@comment) and return unless @comment.update(comment_update_params)

          render json: @article, status: :ok
        end

        # DELETE api/v1/pubweave/blog_article_comments/:id
        def destroy
          head :no_content if @comment.destroy
        end

        private

        def set_comment
          @comment = BlogArticleComment.find(params[:id])
        end

        def comment_params
          params.require(:blog_article_comment).permit(:blog_article_id, :commenter_id, :comment)
        end

        def comment_update_params
          params.require(:blog_article_comment).permit(:comment)
        end
      end
    end
  end
end
