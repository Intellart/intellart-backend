module Api
  module V1
    module Pubweave
      class BlogArticleCommentLikesController < ApplicationController
        before_action :set_comment_like, only: [:destroy]
        after_action :refresh_jwt, only: [:create, :destroy]
        skip_before_action :authenticate_api_user!, only: [:index]

        rescue_from ActiveRecord::RecordNotFound do
          render_json_error :not_found, :article_comment_like_not_found
        end
        rescue_from ActiveRecord::RecordNotDestroyed do
          render_json_error :not_destroyed, :article_comment_like_not_destroyed
        end

        # GET api/v1/pubweave/blog_article_comment_likes/
        def index
          @comments = []

          if request.query_parameters.any?
            @likes = BlogArticleCommentLike.where(request.query_parameters)
            comments = nil
            @likes.each do |like|
              comments = BlogArticleComment.where(id: like[:blog_article_comment_id]) if comments.nil?
              comments = comments.or(BlogArticleComment.where(id: like[:blog_article_comment_id])) if comments.present?
            end
            @comments = comments
          end

          render json: @comments, status: :ok
        end

        # POST api/v1/pubweave/blog_article_comment_likes/
        def create
          @like = BlogArticleCommentLike.new(like_create_params)
          render_json_validation_error(@like) and return unless @like.save

          @comment = BlogArticleComment.find(@like[:blog_article_comment_id])
          render json: @comment, status: :ok
        end

        # POST api/v1/pubweave/blog_article_comment_likes/:id
        def destroy
          return unless @like.destroy

          @comment = BlogArticleComment.find(@like[:blog_article_comment_id])
          render json: @comment, status: :ok
        end

        private

        def set_comment_like
          @like = BlogArticleCommentLike.find(params[:id])
        end

        def like_create_params
          params.require(:like).permit(:blog_article_comment_id, :user_id)
        end
      end
    end
  end
end
