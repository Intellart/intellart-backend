class CardanoAddress < ApplicationRecord
  has_many :nfts

  def active_model_serializer
    CardanoAddressSerializer
  end
end
