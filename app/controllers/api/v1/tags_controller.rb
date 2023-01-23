module Api
  module V1
    class TagsController < ApplicationController
      skip_before_action :authenticate_api_user!, only: [:index]

      rescue_from ActiveRecord::RecordNotFound do
        render_json_error :not_found, :tag_not_found
      end

      def index
        tags = Tag.all
        render json: tags, status: :ok
      end

      def create
        @tag = Tag.new(tag_params)
        render_json_validation_error(@tag) and return unless @tag.save

        render json: @tag, status: :created
      end

      private

      def tag_params
        params.require(:tag).permit(:tag)
      end
    end
  end
end
