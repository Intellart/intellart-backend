module Api
  module V1
    module Pubweave
      class BlogArticleCommentDislikesController < ApplicationController
        before_action :set_comment_dislike, only: [:destroy]
        after_action :refresh_jwt, only: [:create, :destroy]
        skip_before_action :authenticate_api_user!, only: [:index]

        rescue_from ActiveRecord::RecordNotFound do
          render_json_error :not_found, :article_comment_dislike_not_found
        end
        rescue_from ActiveRecord::RecordNotDestroyed do
          render_json_error :not_destroyed, :article_comment_dislike_not_destroyed
        end

        # GET api/v1/pubweave/blog_article_comment_dislikes/
        def index
          @comments = []

          if request.query_parameters.any?
            @dislikes = BlogArticleCommentDislike.where(request.query_parameters)
            comments = nil
            @dislikes.each do |dislike|
              comments = BlogArticleComment.where(id: dislike[:blog_article_comment_id]) if comments.nil?
              comments = comments.or(BlogArticleComment.where(id: dislike[:blog_article_comment_id])) if comments.present?
            end
            @comments = comments
          end

          render json: @comments, status: :ok
        end

        # POST api/v1/pubweave/blog_article_comment_dislikes/
        def create
          @dislike = BlogArticleCommentDislike.new(dislike_create_params)
          render_json_validation_error(@dislike) and return unless @dislike.save

          @comment = BlogArticleComment.find(@dislike[:blog_article_comment_id])
          render json: @comment, status: :ok
        end

        # POST api/v1/pubweave/blog_article_comment_dislikes/:id
        def destroy
          return unless @dislike.destroy

          @comment = BlogArticleComment.find(@dislike[:blog_article_comment_id])
          render json: @comment, status: :ok
        end

        private

        def set_comment_dislike
          @dislike = BlogArticleCommentDislike.find(params[:id])
        end

        def dislike_create_params
          params.require(:dislike).permit(:blog_article_comment_id, :user_id)
        end
      end
    end
  end
end
