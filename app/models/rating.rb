class Rating < ApplicationRecord
  belongs_to :user
  # belongs_to :rated_user

  validates :rated_user_id, uniqueness: { scope: :user_id, message: 'This user was already rated by this user.' }
end
