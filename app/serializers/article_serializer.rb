class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :subtitle, :content, :author, :likes, :status, :description, :image, :category, :created_at, :updated_at, :star, :comments, :tags

  def author
    UserSerializer.new(object.author).to_h.slice(:id, :eamil, :first_name, :last_name, :full_name)
  end

  def category
    object.category_id ? Category.find(object.category_id).category_name : ''
  end

  def comments
    ActiveModelSerializers::SerializableResource.new(object.comments,
                                                     each_serializer: CommentSerializer).as_json
  end

  def content
    payload = object.content
    payload['blocks'] = JSON.parse(object.sections.to_json)
    payload
  end

  def image
    object.image_url
  end

  def likes
    ActiveModelSerializers::SerializableResource.new(object.ratings.likes,
                                                     each_serializer: RatingSerializer,
                                                     fields: [:id, :user_id]).as_json
  end
end
