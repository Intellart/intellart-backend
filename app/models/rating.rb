class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :rated_user
end
