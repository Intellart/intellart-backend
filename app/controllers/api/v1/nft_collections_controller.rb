class Api::V1::NftCollectionsController < ApplicationController
  after_action :refresh_jwt

  rescue_from ActiveRecord::RecordNotFound do
    render_json_error :not_found, :nft_collection_not_found
  end

  def index
    collections = NftCollection.all
    render json: collections, status: :ok
  end
end
