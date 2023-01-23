module Api
  module V1
    module Pubweave
      class BlogArticleTagsController < ApplicationController
        skip_before_action :authenticate_api_user!, only: [:index]
        before_action :require_owner, only: [:destroy]
        before_action :set_article_tag, only: [:destroy]

        def index
          tags = BlogArticleTag.all
          render json: tags, status: :ok
        end

        def create
          @article_tag = BlogArticleTag.new(article_tags_params)
          render_json_validation_error(@article_tag) and return unless @article_tag.save

          render json: @article_tag, status: :created
        end

        # DELETE api/v1/pubweave/blog_article_tags/:id
        def destroy
          render json: @article_tag.id, status: ok if @article_tag.destroy
        end

        private

        def set_article_tag
          @article_tag = BlogArticleTag.find(params[:id])
        end

        def require_owner
          head :unauthorized unless @current_user.id == @article_tag.blog_article.user_id
        end

        def article_tags_params
          params.require(:blog_article_tag).permit(:tag_id, :blog_article_id, :category_id)
        end
      end
    end
  end
end
