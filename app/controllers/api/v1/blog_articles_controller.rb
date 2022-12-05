module Api
  module V1
    class BlogArticlesController < ApplicationController
      before_action :set_blog_article, only: [:show, :destroy]
      skip_before_action :authenticate_api_user!, only: [:index]

      rescue_from ActiveRecord::RecordNotFound do
        render_json_error :not_found, :blog_article_not_found
      end

      def index
        blog_articles = BlogArticle.all
        render json: blog_articles, status: :ok
      end

      def show
        render json: @blog_article, status: :ok
      end

      def create

      end

      def update

      end

      def destroy

      end

      private

      def set_blog_article
        @blog_article = BlogArticle.find(params[:id])
      end

      def blog_article_params
        params.require(:blog_article).permit(:blog_id, :title, :subtitle, :content)
      end
    end
  end
end
