module Api
  module V1
    module Intellart
      class NftsController < ApplicationController
        before_action :set_nft, except: [:index, :create, :index_mint_request, :index_minted, :index_on_sale, :index_user_nfts]
        before_action :require_owner, only: [:update, :destroy]
        after_action :refresh_jwt, only: [:create, :update, :destroy]
        after_action :run_minting_and_confirmation_job, only: [:accept_minting]
        skip_before_action :authenticate_api_user!, only: [:index, :index_minted, :index_mint_request, :index_on_sale]
        before_action :authenticate_api_admin!, only: [:accept_minting, :reject_minting, :sell_init]

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

        # GET api/nfts/index_mint_request
        def index_mint_request
          @nfts = Nft.where(state: 'request_for_minting')
          render json: @nfts, status: :ok
        end

        # GET api/nfts/index_minted
        def index_minted
          @nfts = Nft.where(state: %w[minting_accepted minted])
          render json: @nfts, status: :ok
        end

        # GET api/nfts/index_on_sale
        def index_on_sale
          @nfts = Nft.where(state: 'on_sale')
          render json: @nfts, status: :ok
        end

        # GET api/v1/intellart/nfts/index_user_nfts?owner_id=
        def index_user_nfts
          @nfts = []
          @nfts = Nft.where(request.query_parameters) if request.query_parameters.any?

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

          render_json_validation_error(@nft) and return unless @nft.update(asset_name: asset_name)

          long_url = ActiveStorage::Blob.where(filename: params[:nft][:file].original_filename).last.url
          @nft.url = ShortURL.shorten(long_url)

          render_json_validation_error(@nft) and return unless @nft.save

          render json: @nft, status: :created
        end

        def update; end

        def update_tx_and_witness
          render json: { errors: @nft.errors.full_messages }, status: :unprocessable_entity unless @nft.update(nft_params)
          render json: @nft, status: :ok
        end

        def update_seller
          render json: { errors: @nft.errors.full_messages }, status: :unprocessable_entity unless @nft.update(nft_params)
          render json: @nft, status: :ok
        end

        # DELETE api/nfts/:id
        def destroy
          head :no_content if @nft.destroy
        end

        def close_sale
          @nft.sell_success!

          render_json_validation_error(@nft) and return unless @nft.sell_success?

          render_json_validation_error(@nft) and return unless @nft.update(sold_count: @nft.sold_count + 1)

          render json: @nft, status: :ok
        end

        # TODO: Implement CheckMintSuccessJob to run every 5 mins, 12 times in total
        def accept_minting
          @nft.accept_minting!
          render json: @nft, status: :ok if @nft.minting_accepted?
        end

        def reject_minting
          @nft.reject_minting!
          render json: @nft, status: :ok if @nft.minting_rejected?
        end

        def initiate_sale
          @nft.sell_init!
          render json: @nft, status: :ok if @nft.on_sale?
        end

        private

        def run_minting_and_confirmation_job
          fingerprint = @nft.fingerprint
          response = @nft.send_to_minting
          return unless response.code == 200

          CheckMintSuccessJob.perform_now(fingerprint)
        end

        def last_created_nft_id
          Nft.order('created_at').last.nft_id
        end

        def asset_name
          format('INT%05d', last_created_nft_id)
        end

        # only owner can modify/delete nft
        def require_owner
          head :unauthorized unless @nft.owner_id == @current_user.id
        end

        def set_nft
          @nft = Nft.find(params[:id])
        end

        def nft_params
          params.require(:nft).permit(
            :fingerprint, :tradeable, :price, :name, :description, :subject, :owner_id, :nft_collection_id, :category_id,
            :policy_id, :seller_address, :url, :witness, :tx_id, :file
          )
        end
      end
    end
  end
end
