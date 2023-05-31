module Imageable
  def save_and_upload_image(parameters, object)
    return unless parameters[:image].present?

    Image.transaction do
      img = parameters[:image]
      image = Cloudinary::Uploader.upload(img.path)
      @image = Image.new(owner: object, asset_id: image['asset_id'],
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
                         name: img.original_filename)
      @image.save!
    end
  end
end
