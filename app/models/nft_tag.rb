class NftTag < ApplicationRecord
  belongs_to :tag
  belongs_to :nft, foreign_key: :fingerprint

  validates :fingerprint, uniqueness: { scope: :tag_id, message: 'Tag already exists on this NFT.' }

  def active_model_serializer
    NftTagSerializer
  end
end
