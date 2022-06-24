class CardanoAddressSerializer < ActiveModel::Serializer
  attributes :id, :address, :dirty, :wallet_id

  belongs_to :wallet
  #belongs_to :user, through: :wallet
end
