class WalletSerializer < ActiveModel::Serializer
  attributes :id, :total, :used, :cardano_addresses

  belongs_to :user
  has_many :cardano_addresses
end
