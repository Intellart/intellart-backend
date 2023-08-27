class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :article_type, :title, :subtitle, :content, :author, :likes, :status, :description, :image, :category, :created_at, :updated_at, :star, :comments, :tags, :active_sections

  def author
    UserSerializer.new(object.author).to_h.slice(:id, :email, :username, :first_name, :last_name, :full_name)
  end

  def category
    object.category_id ? Category.find(object.category_id).category_name : ''
  end

  def comments
    ActiveModelSerializers::SerializableResource.new(object.comments, each_serializer: CommentSerializer).as_json
  end

  def content
    payload = object.content.to_h
    payload['blocks'] = JSON.parse(ActiveModelSerializers::SerializableResource.new(object.sections, each_serializer: SectionSerializer).to_json)
    payload
  end

  def image
    object.image.url if object.image.present?
  end

  def likes
    ActiveModelSerializers::SerializableResource.new(object.ratings.likes,
                                                     each_serializer: RatingSerializer,
                                                     fields: [:id, :user_id]).as_json
  end
end
