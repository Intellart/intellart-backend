class Nft < ApplicationRecord
  has_many :nft_tags
  has_many :nft_likes
  has_many :nft_endorsers
end
