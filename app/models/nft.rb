class Nft < ApplicationRecord
  has_many :nft_tags
  has_many :nft_likes
  has_many :nft_endorsers
  belongs_to :user, foreign_key: "owner_id"
  belongs_to :onchain_transaction
end
