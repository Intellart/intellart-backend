module Api
  module V1
    class BlogArticleCommentsController < ApplicationController
      before_action :set_blog_article_comment, only: [:show, :destroy]
      skip_before_action :authenticate_api_user!, only: [:index]

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

      def create

      end

      def update

      end

      def destroy

      end

      private

      def set_comment
        @comment = BlogArticleComment.find(params[:id])
      end

      def blog_article_comment_params
        params.require(:blog_article_comment).permit(:blog_article_id, :commenter_id, :comment)
      end
    end
  end
end
