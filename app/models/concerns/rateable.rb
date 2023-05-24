module Rateable
  def rate!(rater, rating)
    Rating.transaction do
      current_rating = ratings.where(user: rater)
      current_rating.destroy! if current_rating.present?
      return if current_rating&.rating == rating

      rating = Rating.create!(rating: rating, user: rater, rating_subject: @comment)
    end
    true
  end
end
