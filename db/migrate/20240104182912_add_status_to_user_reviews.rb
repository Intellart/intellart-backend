class AddStatusToUserReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :user_reviews, :status, :string
  end
end
