class NftEndorser < ApplicationRecord
  belongs_to :user
  belongs_to :nft, foreign_key: :fingerprint

  validates :fingerprint, uniqueness: { scope: :user_id, message: 'This user has already endorsed this NFT.' }

  def active_model_serializer
    NftEndorserSerializer
  end
end
