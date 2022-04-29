class NftLike < ApplicationRecord
  belongs_to :user
  belongs_to :nft, foreign_key: :fingerprint

  validates :fingerprint, uniqueness: { scope: :user_id, message: 'This user has already liked this NFT.' }

  def active_model_serializer
    NftLikeSerializer
  end
end
