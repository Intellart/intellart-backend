class Api::V1::CategoriesController < ApplicationController
  skip_before_action :authenticate_api_user!, only: [:index]

  rescue_from ActiveRecord::RecordNotFound do
    render_json_error :not_found, :category_not_found
  end

  def index
    test_array = []
    categories = Category.all
    test_array << categories << 'testestestest'
    render json: test_array, status: :ok
  end
end
