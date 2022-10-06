class Api::V1::SellNftsController < ApplicationController
  before_action :set_nft, only: [:approve, :decline]
  before_action :authenticate_api_admin!

  rescue_from ActiveRecord::RecordNotFound do
    render_json_error :not_found, :nft_not_found
  end

  # GET api/sell_nfts/
  def index
    @sell_nfts = SellNft.where(status: 'waiting')

    render json: @sell_nfts, status: :ok
  end

  # POST api/sell_nfts/:id
  def approve
    @sell_nft.status = 'approved'

    # TODO: initiate the transaction or wait for user to do that?

    render_json_validation_error(@sell_nft) unless @sell_nft.save

    render json: @sell_nft, status: :created
  end

  # DELETE api/sell_nfts/:id
  def decline
    @sell_nft.status = 'declined'
    return unless @sell_nft.save

    render json: 'Sell of Nft successfully declined.', status: :ok
  end

  private

  def set_nft
    @sell_nft = SellNft.find(params[:id])
  end

  def nft_params
    params.permit(
      :fingerprint, :tradeable, :price, :name, :description, :subject, :owner_id, :nft_collection_id, :category_id,
      :asset_name, :policy_id, :status, :url, :cardano_address_id
    )
  end
end
