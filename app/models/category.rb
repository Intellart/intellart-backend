class Category < ApplicationRecord
  def active_model_serializer
    CategorySerializer
  end
end
