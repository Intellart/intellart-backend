module Api
  module V1
    module Intellart
      class NftsController < ApplicationController
        before_action :set_nft, except: [:index, :create, :index_mint_request, :index_minted, :index_on_sale]
        before_action :require_owner, only: [:update, :destroy]
        after_action :refresh_jwt, only: [:create, :update, :destroy]
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

        # GET api/nfts/:id
        def show
          render json: @nft, status: :ok
        end

        # POST api/nfts/
        def create
          @nft = Nft.new(nft_params)
          if @nft.save
            @nft.url = ActiveStorage::Blob.where(filename: params[:nft][:file].original_filename).last.url
            @nft.save
          else
            render_json_validation_error(@nft) and return
          end
          render json: @nft, status: :created
        end

        def update; end

        def update_tx_and_witness
          if @nft.update(nft_params)
            render json: { message: 'Successfully updated tx and witness for this NFT' }, status: :ok
          else
            render json: { errors: @nft.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def update_seller
          if @nft.update(nft_params)
            render json: { message: 'Successfully updated seller for this NFT' }, status: :ok
          else
            render json: { errors: @nft.errors.full_messages }, status: :unprocessable_entity
          end
        end

        # DELETE api/nfts/:id
        def destroy
          head :no_content if @nft.destroy
        end

        # TODO: Implement CheckMintSuccessJob to run every 5 mins, 12 times in total
        def accept_minting
          @nft.accept_minting!
          response = @nft.send_to_minting
          # if response.code == 200
          #   CheckMintSuccessJob.perform_now!(@nft)
          # end
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
            :asset_name, :policy_id, :seller_address, :url, :witness, :tx_id, :file
          )
        end
      end
    end
  end
end
