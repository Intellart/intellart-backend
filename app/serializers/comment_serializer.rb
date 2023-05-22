class CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :likes, :dislikes, :created_at, :updated_at, :reply_to_id

  def dislikes
    ActiveModelSerializers::SerializableResource.new(object.ratings.dislikes,
                                                     each_serializer: RatingSerializer,
                                                     fields: [:id, :user_id]).as_json
  end

  def likes
    ActiveModelSerializers::SerializableResource.new(object.ratings.likes,
                                                     each_serializer: RatingSerializer,
                                                     fields: [:id, :user_id]).as_json
  end
end
