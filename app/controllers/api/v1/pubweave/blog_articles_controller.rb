module Api
  module V1
    module Pubweave
      class BlogArticlesController < ApplicationController
        before_action :set_article, only: [:show, :update, :destroy]
        before_action :authenticate_api_user!, except: [:index, :show]
        after_action :refresh_jwt, only: [:create, :update, :destroy]
        before_action :require_owner, only: [:update, :destroy]
        before_action :authenticate_domain, except: [:index, :show]

        rescue_from ActiveRecord::RecordNotFound do
          render_json_error :not_found, :blog_article_not_found
        end

        # GET api/v1/pubweave/blog_articles/
        def index
          articles = BlogArticle.all
          render json: articles, status: :ok
        end

        # GET api/v1/pubweave/blog_articles/:id
        def show
          render json: @article, status: :ok
        end

        # POST api/v1/pubweave/blog_articles/
        def create
          @article = BlogArticle.new(article_params)
          render_json_validation_error(@article) and return unless @article.save

          render json: @article, status: :created
        end

        # PUT/PATCH api/v1/pubweave/blog_articles/:id
        def update
          render_json_validation_error(@article) and return unless @article.update(article_update_params)

          render json: @article, status: :ok
        end

        # DELETE api/v1/pubweave/blog_articles/:id
        def destroy
          head :no_content if @article.destroy
        end

        private

        def require_owner
          head :unauthorized unless @current_user.id == @article.user_id
        end

        def set_article
          @article = BlogArticle.find(params[:id])
        end

        def article_params
          params.require(:blog_article).permit(:user_id, :title, :subtitle, :content)
        end

        def article_update_params
          params.require(:blog_article).permit(:title, :subtitle, :content)
        end
      end
    end
  end
end
