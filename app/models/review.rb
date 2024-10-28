class Review < ApplicationRecord
  belongs_to :article

  has_many :user_reviews, dependent: :destroy
  has_many :users, through: :user_reviews

  validates :amount, :deadline, presence: true
end
