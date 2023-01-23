module Api
  module V1
    class CategoriesController < ApplicationController
      skip_before_action :authenticate_api_user!, only: [:index]

      rescue_from ActiveRecord::RecordNotFound do
        render_json_error :not_found, :category_not_found
      end

      def index
        categories = Category.all
        render json: categories, status: :ok
      end

      def create
        @category = Category.new(category_params)
        render_json_validation_error(@category) and return unless @category.save

        render json: @category, status: :created
      end

      private

      def category_params
        params.require(:category).permit(:category_name)
      end
    end
  end
end
