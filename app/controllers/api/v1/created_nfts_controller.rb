class Api::V1::CreatedNftsController < ApplicationController
  before_action :set_nft, only: [:show, :approve, :decline, :destroy]
  #before_action :require_owner, only: [:update, :destroy]
  #skip_before_action :authenticate_api_user!, only: [:index]
  before_action :authenticate_api_admin!

  rescue_from ActiveRecord::RecordNotFound do
    render_json_error :not_found, :nft_not_found
  end

  rescue_from ActiveRecord::RecordNotDestroyed do
    render_json_error :not_destroyed, :nft_not_destroyed
  end

  # GET api/created_nfts/:id
  def show
    render json: @created_nft, status: :ok
  end

  # POST api/created_nfts/:id
  def new
    nft = CreatedNft.new(nft_params)

    if nft.save
      render json: nft, status: :created
    else
      render_json_validation_error(nft)
    end
  end

  # GET api/created_nfts/
  def index
    @created_nfts = CreatedNft.where(status: 'waiting')

    render json: @created_nfts, status: :ok
  end

  # DELETE api/created_nfts/:id
  def destroy
    head :no_content if @created_nft.destroy
  end

  # POST api/created_nfts/approve/:id
  def approve
    # mint(@nft) then save to the db
    @nft = Nft.new(
      fingerprint: @created_nft.id,
      tradeable: @created_nft.tradeable,
      price: @created_nft.price,
      name: @created_nft.name,
      description: @created_nft.description,
      subject: @created_nft.subject,
      url: @created_nft.url,
      owner_id: @created_nft.owner_id,
      cardano_address_id: @created_nft.cardano_address_id,
      nft_collection_id: @created_nft.nft_collection_id,
      category_id: @created_nft.category_id,
      asset_name: @created_nft.asset_name,
      policy_id: @created_nft.policy_id,
      # TODO: change this to real transaction id once the minting is complete
      onchain_transaction_id: 1
    )

    if @nft.save
      @created_nft.status = 'approved'
      if @created_nft.save
        render json: @created_nft, status: :created
      else
        render_json_validation_error(@created_nft)
      end
    else
      render_json_validation_error(@nft)
    end
  end

  # DELETE api/created_nfts/decline/:id
  def decline
    @created_nft.status = 'declined'
    return unless @created_nft.save

    render json: 'Nft minting successfully declined.', status: :ok
  end

  private

  def mint
    # Minting logic...
    # save onchain_transaction
    onchain_tx = OnchainTransaction.new
    return unless onchain_tx.save
  end

  def set_nft
    @created_nft = CreatedNft.find(params[:id])
  end

  def nft_params
    params.permit(
      :fingerprint, :tradeable, :price, :name, :description, :subject, :owner_id, :nft_collection_id, :category_id,
      :asset_name, :policy_id, :status, :url, :cardano_address_id
    )
  end
end
