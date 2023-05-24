module Rateable
  def rate!(rater, rating)
    Rating.transaction do
      current_rating = ratings.find_by(user: rater)
      current_rating.destroy if current_rating.present?

      Rating.create!(rating: rating, user: rater, rating_subject: self) unless current_rating.present? && current_rating&.rating == rating.to_s
    end
    true
  end
end
