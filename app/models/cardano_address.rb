class CardanoAddress < ApplicationRecord
  def active_model_serializer
    CardanoAddressSerializer
  end
end
