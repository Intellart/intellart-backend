class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :amount, :deadline, :article_id, :user_reviews

  def user_reviews
    UserReviewSerializer.new(object.user_reviews)
    object.user_reviews.map { |user_review| UserReviewSerializer.new(user_review) }
  end
end
