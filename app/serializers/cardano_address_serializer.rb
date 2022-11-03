class CardanoAddressSerializer < ActiveModel::Serializer
  attributes :id, :address, :dirty
end
