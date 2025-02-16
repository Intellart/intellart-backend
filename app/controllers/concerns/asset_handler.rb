module AssetHandler
  def save_and_upload_image(parameters, owner = nil)
    return unless parameters[:image].present? || parameters[:file].present?

    asset_params = parameters[:image] || parameters[:file]
    asset_path = asset_params.path
    asset_name = asset_params.original_filename

    @asset_model = parameters[:image].present? ? Image : Attachment

    @asset_model.transaction do
      uploaded_image = Cloudinary::Uploader.upload(asset_path)
      params = image_params_to_hash(uploaded_image)
      params[:name] = asset_name

      if owner.present?
        params[:owner] = owner
      end

      @asset = @asset_model.new(params)
      @asset.save!
    end

    @asset
  end

  private

  def image_params_to_hash(cloudinary_asset)
    cloudinary_asset.slice("asset_id", "public_id", "format", "version", "resource_type", "created_at", "bytes", "width", "height", "folder", "url", "secure_url")
  end
end
