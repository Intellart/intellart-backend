class Api::V1::NftsController < ApplicationController
  before_action :authenticate_api_user!
  before_action :set_nft, only: [:show, :destroy]
  after_action :refresh_jwt

  # GET api/nfts/
  def index
    @nfts = Nft.all
    render json: { data: @nfts }
    # render json: NftsRepresenter.new(@nfts).as_json
  end

  # GET api/nfts/:id
  def show
    if @nft
      render json: { data: @nft }, status: :ok
    else
      render json: { error: 'Nft does not exist.' }, status: 404
    end
  end

  # POST api/nfts/
  def create
    @nft = Nft.new(nft_params)
    @nft.save
    render json: { data: @nft }, status: :ok
  rescue => e
    render json: { errors: e.to_json }, status: :unprocessable_entity
  end

  # DELETE api/nfts/:id
  def destroy
    @nft.destroy!
    head :no_content
  end

  private

  def set_nft
    @nft = Nft.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def nft_params
    params.require(:nft).permit(
      :fingerprint, :tradeable, :price, :name, :description, :subject, :owner_id, :nft_collection_id, :category_id,
      :asset_name, :policy_id, :onchain_transaction_id
    )
  end
end
