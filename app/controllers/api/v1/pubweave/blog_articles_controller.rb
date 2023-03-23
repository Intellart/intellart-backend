module Api
  module V1
    module Pubweave
      class BlogArticlesController < ApplicationController
        before_action :set_article, except: [:index, :create, :index_by_user, :index_by_status]
        before_action :authenticate_api_user!, except: [:index, :show, :index_by_user, :index_by_status]
        before_action :deny_published_article_update, only: [:update]
        after_action :refresh_jwt, only: [:create, :update, :destroy]
        before_action :require_owner, only: [:update, :destroy]
        before_action :authenticate_domain, except: [:index, :show, :index_by_user, :index_by_status]
        before_action :authenticate_api_admin!, only: [:accept_publishing, :reject_publishing]

        rescue_from ActiveRecord::RecordNotFound do
          render_json_error :not_found, :blog_article_not_found
        end

        # GET api/v1/pubweave/blog_articles/
        def index
          articles = BlogArticle.all
          render json: articles, status: :ok
        end

        # GET api/v1/pubweave/user_blog_articles/:user_id
        def index_by_user
          articles = BlogArticle.all.where(user_id: article_params[:user_id])
          render json: articles, status: :ok
        end

        # GET api/v1/pubweave/status_blog_articles/:status
        def index_by_status
          articles = BlogArticle.all.where(status: article_params[:status])
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

        # PUT/PATCH api/v1/pubweave/blog_articles/:id/like/
        def like
          @article.likes += 1
          render_json_validation_error(@article) and return unless @article.save

          render json: @article, status: :ok
        end

        # PUT/PATCH api/v1/pubweave/blog_articles/:id
        def update
          render_json_validation_error(@article) and return unless @article.update(article_update_params)

          render json: @article, status: :ok
        end

        # DELETE api/v1/pubweave/blog_articles/:id
        def destroy
          render json: @article.id, status: :ok if @article.destroy
        end

        # PUT api/v1/pubweave/blog_articles/:id/request_publishing
        def request_publishing
          @article.request_publishing!
          render json: @article, status: :ok if @article.requested?
        end

        # PUT api/v1/pubweave/blog_articles/:id/accept_publishing
        def accept_publishing
          @article.accept_publishing!
          render json: @article, status: :ok if @article.published?
        end

        # PUT api/v1/pubweave/blog_articles/:id/reject_publishing
        def reject_publishing
          @article.reject_publishing!
          render json: @article, status: :ok if @article.rejected?
        end

        private

        def deny_published_article_update
          render json: { message: 'You can not edit a published article.' } and return if @article.status == 'published'
        end

        def require_owner
          head :unauthorized unless @current_user.id == @article.user_id || @current_user.super?
        end

        def set_article
          @article = BlogArticle.find(params[:id])
        end

        def article_params
          params.require(:blog_article).permit(:user_id, :title, :subtitle, :content, :description, :status, :image, :star, :category_id)
        end

        def article_update_params
          params.require(:blog_article).permit(:title, :subtitle, :content, :likes, :description, :status, :image, :star, :category_id)
        end
      end
    end
  end
end
