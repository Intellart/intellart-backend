class Attachment < ApplicationRecord
  # asset_id
  # public_id
  # format
  # version
  # resource_type
  # created_at
  # bytes
  # width
  # height
  # folder
  # url
  # secure_url
  # owner

  belongs_to :owner, polymorphic: true

  after_destroy -> { Cloudinary::Api.delete_resources(public_id) }
end
