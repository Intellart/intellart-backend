class NftTagSerializer < ActiveModel::Serializer
  attributes :id, :fingerprint, :user_id, :tag_name

  has_one :tag
  has_one :nft, foreign_key: :fingerprint

  def tag_name
    object.tag_id ? Tag.find(object.tag_id).tag : ''
  end
end
