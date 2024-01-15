class AddReviewContentToUserReview < ActiveRecord::Migration[7.0]
  def change
    add_reference :articles, :user_review, foreign_key: true
  end
end
