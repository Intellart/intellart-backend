class RatingSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :rating
end
