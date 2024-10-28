class UserReviewSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :review_id, :full_name, :status, :review_content

  def full_name
    User.find(object.user_id).full_name
  end

  def review_content
    ArticleSerializer.new(object.review_content) if object.review_content.present?
  end
end
