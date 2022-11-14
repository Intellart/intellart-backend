module Api
  module V1
    class NftsController < ApplicationController
      before_action :set_nft, except: [:index, :create]
      before_action :require_owner, only: [:update, :destroy]
      after_action :refresh_jwt, only: [:create, :update, :destroy]
      skip_before_action :authenticate_api_user!, only: [:index]
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
        @nfts = Nft.where(state: 'request_for_minting')
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
          render_json_validation_error(@nft) and return unless @nft.save
        end
        render json: @nft, status: :created
      end

      def update; end

      # DELETE api/nfts/:id
      def destroy
        head :no_content if @nft.destroy
      end

      # TODO: CheckMintSuccessJob needs to run every 5 minutes for nfts that still have the status minting_in_progress
      # TODO: Add new state on nfts table status column, minting_in_progress
      def accept_minting
        @nft.accept_minting!
        # TODO: handle submitTx part here
        response = @nft.send_to_minting
        # if response.code == 200
        #   @nft.minting_in_progress!
        # end
        puts response
        # CheckMintSuccessJob.perform_now!(@nft)
        render json: @nft, status: :ok if @nft.minting_accepted?
      end

      def reject_minting
        @nft.reject_minting!
        render json: @nft, status: :ok if @nft.minting_rejected?
      end

      def sell_init
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
          :asset_name, :policy_id, :onchain_transaction_id, :cardano_address_id, :url, :file
        )
      end

      # Onchain Cardano address cannot be changed, so we remove it
      def nft_update_params
        params[:nft].delete(:cardano_address_id)
      end
    end
  end
end
