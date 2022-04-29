class NftEndorserSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :fingerprint

  belongs_to :user
  belongs_to :nft, foreign_key: :fingerprint
end
