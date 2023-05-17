class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :rating_subject, polymorphic: true

  validate :one_rating_per_user

  enum rating: {
    dislike: 0,
    one_star: 1,
    two_star: 2,
    three_star: 3,
    four_star: 4,
    five_star: 5,
    like: 6
  }

  scope :likes, -> { where(rating: :like) }
  scope :dislikes, -> { where(rating: :like) }

  def one_rating_per_user
    return if Rating.where(user: user, rating_subject: rating_subject).count.zero?

    errors.add(:user_id, 'You have alreaday given a rating.')
  end

  def self.average_star_rating(scope: {})
    ratings = where(scope).where.not(rating: [:dislike, :like])
    ratings.count != 0 ? ratings.sum(:rating) / ratings.count : 0
  end
end
