class Api::V1::NftsController < ApplicationController
  before_action :set_nft, only: [:show, :update, :destroy]
  after_action :refresh_jwt, only: [:create, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound do
    render_json_error :not_found, :nft_not_found
  end

  rescue_from ActiveRecord::RecordNotDestroyed do
    render_json_error :not_destroyed, :nft_not_destroyed
  end

  rescue_from ActiveRecord::RecordNotUnique do
    render_json_error :conflict, :nft_not_unique
  end

  # GET api/nfts/
  def index
    @nfts = Nft.all
    render json: @nfts, status: :ok
  end

  # GET api/nfts/:id
  def show
    render json: @nft, status: :ok
  end

  # POST api/nfts/
  def create
    @nft = Nft.new(nft_params)
    render_json_validation_error(@nft) and return unless @nft.save

    render json: @nft, status: :created
  end

  def update; end

  # DELETE api/nfts/:id
  def destroy
    head :no_content if @nft.destroy
  end

  private

  def set_nft
    @nft = Nft.find(params[:id])
  end

  def nft_params
    params.require(:nft).permit(
      :fingerprint, :tradeable, :price, :name, :description, :subject, :owner_id, :nft_collection_id, :category_id,
      :asset_name, :policy_id, :onchain_transaction_id
    )
  end
end
