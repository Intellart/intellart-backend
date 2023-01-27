module Api
  module V1
    module Intellart
      class NftLikesController < ApplicationController
        before_action :set_nft_like, only: [:destroy]
        after_action :refresh_jwt, only: [:create, :destroy]
        skip_before_action :authenticate_api_user!, only: [:index]

        rescue_from ActiveRecord::RecordNotFound do
          render_json_error :not_found, :nft_not_found
        end
        rescue_from ActiveRecord::RecordNotDestroyed do
          render_json_error :not_destroyed, :nft_not_destroyed
        end

        # GET api/nft_likes/
        def index
          @nfts = []

          if request.query_parameters.any?
            @likes = NftLike.where(request.query_parameters)
            nfts = nil
            @likes.each do |like|
              nfts = Nft.where(fingerprint: like[:fingerprint]) if nfts.nil?
              nfts = nfts.or(Nft.where(fingerprint: like[:fingerprint])) if nfts.present?
            end
            @nfts = nfts
          end

          render json: @nfts, status: :ok
        end

        # POST api/nft_likes/
        def create
          @like = NftLike.new(like_create_params)
          render_json_validation_error(@like) and return unless @like.save

          @nft = Nft.find(@like[:fingerprint])
          render json: @nft, status: :ok
        end

        # POST api/nft_likes/:id
        def destroy
          return unless @like.destroy

          @nft = Nft.find(@like[:fingerprint])
          render json: @nft, status: :ok
        end

        private

        def set_nft_like
          @like = NftLike.find(params[:id])
        end

        def like_create_params
          params.require(:like).permit(:fingerprint, :user_id)
        end
      end
    end
  end
end
