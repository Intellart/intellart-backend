class UserReviewSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :review_id, :full_name

  def full_name
    User.find(object.user_id).full_name
  end
end
