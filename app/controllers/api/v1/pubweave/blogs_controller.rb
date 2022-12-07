module Api
  module V1
    module Pubweave
      class BlogsController < ApplicationController
        before_action :set_blog, only: [:show, :update, :destroy]
        before_action :authenticate_api_user!, except: [:index]
        after_action :refresh_jwt, only: [:create, :update, :destroy]

        rescue_from ActiveRecord::RecordNotFound do
          render_json_error :not_found, :blog_not_found
        end

        # GET api/v1/pubweave/blogs/
        def index
          blogs = Blog.all
          render json: blogs, status: :ok
        end

        # GET api/v1/pubweave/blogs/:id
        def show
          render json: @blog, status: :ok
        end

        # POST api/v1/pubweave/blogs/
        def create
          @blog = Blog.new(blog_params)
          render_json_validation_error(@blog) and return unless @blog.save

          render json: @blog, status: :created
        end

        # PUT/PATCH api/v1/pubweave/blogs/:id
        def update
          render_json_validation_error(@blog) and return unless @blog.update(blog_update_params)

          render json: @blog, status: :ok
        end

        # DELETE api/v1/pubweave/blogs/:id
        def destroy
          head :no_content if @blog.destroy
        end

        private

        def set_blog
          @blog = Blog.find(params[:id])
        end

        def blog_params
          params.require(:blog).permit(:user_id, :name)
        end

        def blog_update_params
          params.require(:blog).permit(:name)
        end
      end
    end
  end
end
