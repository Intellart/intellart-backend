class Nft < ApplicationRecord
  has_many :tags, class_name: 'NftTag', foreign_key: :fingerprint
  has_many :likes, class_name: 'NftLike', foreign_key: :fingerprint
  has_many :endorsers, class_name: 'NftEndorser', foreign_key: :fingerprint
  belongs_to :user, foreign_key: 'owner_id'
  belongs_to :onchain_transaction

  validates :fingerprint, presence: true, uniqueness: true
  validates :policy_id, :asset_name, presence: true

  after_create :new_nft_broadcast

  def active_model_serializer
    NftSerializer
  end

  private

  def new_nft_broadcast
    ActionCable.server.broadcast(
      "general_channel",
      {
        type: 'nft',
        data: self
      }
    )
  end

  # def to_json(*)
  #   {
  #     fingerprint: fingerprint,
  #     policy_id: policy_id,
  #     asset_name: asset_name,
  #     name: name,
  #     tradeable: tradeable,
  #     price: price,
  #     verified: verified,
  #     description: description,
  #     url: url,
  #     subject: subject,
  #     owner: user.full_name,
  #     category: category,
  #     nft_collection: nft_collection,
  #     transaction_id: onchain_transaction.transaction_id,
  #     cardano_address: cardano_address
  #   }
  # end
end
