module Api
  module V1
    module Pubweave
      # This controller handles the uploading of assets and images in the Pubweave API.
      class UploadsController < ApplicationController
        before_action :authenticate_api_user!
        before_action :authenticate_domain
        before_action :set_paper_trail_whodunnit
        after_action :refresh_jwt, only: [:upload_asset]

        include AssetHandler

        # POST api/v1/pubweave/uploads/upload_asset
        # 
        # Editor - Image Block API endpoint
        # 
        # Uploads an asset to Cloudinary.
        # DOES NOT have an owner YET, Editor has to officially
        # call article update with THIS url in some block.
        def upload_asset
          @asset = save_and_upload_image(params, nil)
          render json: @asset.url, status: :ok
        end
      end
    end
  end
end
