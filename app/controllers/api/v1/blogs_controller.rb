module Api
  module V1
    class BlogsController < ApplicationController
      before_action :set_blog, only: [:show, :destroy]
      skip_before_action :authenticate_api_user!, only: [:index]

      rescue_from ActiveRecord::RecordNotFound do
        render_json_error :not_found, :blog_not_found
      end

      def index
        blogs = Blog.all
        render json: blogs, status: :ok
      end

      def show
        render json: @blog, status: :ok
      end

      def create

      end

      def update

      end

      def destroy

      end

      private

      def set_blog
        @blog = Blog.find(params[:id])
      end

      def blog_params
        params.require(:blog).permit(:user_id)
      end
    end
  end
end
