module Api
  module V1
    module Pubweave
      class BlogArticleTagsController < ApplicationController
        skip_before_action :authenticate_api_user!, only: [:index]

        def index
          tags = BlogArticleTag.all
          render json: tags, status: :ok
        end

        def create
          @article_tag = BlogArticleTag.new(article_tags_params)
          render_json_validation_error(@article_tag) and return unless @article_tag.save

          render json: @article_tag, status: :created
        end

        private

        def article_tags_params
          params.require(:blog_article_tag).permit(:tag_id, :blog_article_id)
        end
      end
    end
  end
end
