module Api
  module V1
    module Pubweave
      class UploadsController < ApplicationController
        before_action :authenticate_api_user!
        before_action :authenticate_domain
        before_action :set_paper_trail_whodunnit
        after_action :refresh_jwt, only: [:upload_asset]

        # POST api/v1/pubweave/uploads/upload_asset
        def upload_asset
          if params['file'].present?
            Attachment.transaction do
              file = Cloudinary::Uploader.upload(params[:file].path)
              @asset = Attachment.new(asset_id: file['asset_id'],
                                      public_id: file['public_id'],
                                      format: file['format'],
                                      version: file['version'],
                                      resource_type: file['resource_type'],
                                      created_at: file['created_at'],
                                      bytes: file['bytes'],
                                      width: file['width'],
                                      height: file['height'],
                                      folder: file['folder'],
                                      url: file['url'],
                                      secure_url: file['secure_url'],
                                      name: params[:file].original_filename)
            end
          elsif params['image'].present?
            Image.transaction do
              image = Cloudinary::Uploader.upload(params[:image].path)
              @asset = Image.new(asset_id: image['asset_id'],
                                 public_id: image['public_id'],
                                 format: image['format'],
                                 version: image['version'],
                                 resource_type: image['resource_type'],
                                 created_at: image['created_at'],
                                 bytes: image['bytes'],
                                 width: image['width'],
                                 height: image['height'],
                                 folder: image['folder'],
                                 url: image['url'],
                                 secure_url: image['secure_url'],
                                 name: params[:image].original_filename)
            end
          end
          @asset.save!
          render json: @asset.url, status: :ok
        end
      end
    end
  end
end
