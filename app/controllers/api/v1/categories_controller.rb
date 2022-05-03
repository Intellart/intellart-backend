class Api::V1::CategoriesController < ApplicationController
  after_action :refresh_jwt

  rescue_from ActiveRecord::RecordNotFound do
    render_json_error :not_found, :category_not_found
  end

  def index
    categories = Category.all
    render json: categories, status: :ok
  end
end
