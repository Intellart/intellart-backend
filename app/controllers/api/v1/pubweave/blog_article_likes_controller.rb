module Api
  module V1
    module Pubweave
      class BlogArticleLikesController < ApplicationController
        before_action :set_article_like, only: [:destroy]
        after_action :refresh_jwt, only: [:create, :destroy]
        skip_before_action :authenticate_api_user!, only: [:index]

        rescue_from ActiveRecord::RecordNotFound do
          render_json_error :not_found, :article_like_not_found
        end
        rescue_from ActiveRecord::RecordNotDestroyed do
          render_json_error :not_destroyed, :article_like_not_destroyed
        end

        # GET api/v1/pubweave/blog_article_likes/
        def index
          @articles = []

          if request.query_parameters.any?
            @likes = BlogArticleLike.where(request.query_parameters)
            articles = nil
            @likes.each do |like|
              articles = BlogArticle.where(id: like[:blog_article_id]) if articles.nil?
              articles = articles.or(BlogArticle.where(id: like[:blog_article_id])) if articles.present?
            end
            @articles = articles
          end

          render json: @articles, status: :ok
        end

        # POST api/v1/pubweave/blog_article_likes/
        def create
          @like = BlogArticleLike.new(like_create_params)
          render_json_validation_error(@like) and return unless @like.save

          @article = BlogArticle.find(@like[:blog_article_id])
          render json: @article, status: :ok
        end

        # POST api/v1/pubweave/blog_article_likes/:id
        def destroy
          return unless @like.destroy

          @article = BlogArticle.find(@like[:blog_article_id])
          render json: @article, status: :ok
        end

        private

        def set_nft_like
          @like = BlogArticleLike.find(params[:id])
        end

        def like_create_params
          params.require(:like).permit(:blog_article_id, :user_id)
        end
      end
    end
  end
end
