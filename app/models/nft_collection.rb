class NftCollection < ApplicationRecord
  def active_model_serializer
    NftCollectionSerializer
  end
end
