class SellNft < ApplicationRecord
  has_many :tags, class_name: 'NftTag', foreign_key: :fingerprint, dependent: :destroy
  has_many :likes, class_name: 'NftLike', foreign_key: :fingerprint, dependent: :destroy
  has_many :endorsers, class_name: 'NftEndorser', foreign_key: :fingerprint, dependent: :destroy
  belongs_to :user, foreign_key: 'owner_id'

  validates :fingerprint, presence: true, uniqueness: true
  validates :policy_id, :asset_name, presence: true

  def active_model_serializer
    SellNftSerializer
  end
end
