module Fileable
  def save_and_upload_file(parameters, object)
    return unless parameters[:file].present?

    Attachment.transaction do
      f = parameters[:file]
      file = Cloudinary::Uploader.upload(f.path)
      @file = Attachment.new(owner: object, asset_id: file['asset_id'],
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
                             name: f.original_filename)
      @file.save!
    end
  end
end
