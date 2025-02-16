class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :subtitle, :content, :author, :likes, :status, :description, :image, :category,
             :created_at, :updated_at, :star, :comments, :tags, :active_sections, :article_type,
             :collaborators, :reviews, :reviewers, :user_review_id, :tx_id, :tx_amount_in_treasury, :slug

  def author
    UserSerializer.new(object.author)
  end

  def category
    object.category_id ? Category.find(object.category_id).category_name : ''
  end

  def collaborators
    ActiveModelSerializers::SerializableResource.new(object.collaborators, each_serializer: UserSerializer).as_json
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

  def reviews
    ActiveModelSerializers::SerializableResource.new(object.reviews, each_serializer: ReviewSerializer)
  end

  def reviewers
    reviews = object.reviews
    user_reviews = reviews.map(&:user_reviews).flatten
    ActiveModelSerializers::SerializableResource.new(user_reviews,
                                                    each_serializer: UserReviewSerializer).as_json
  end
end
