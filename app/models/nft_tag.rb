class NftTag < ApplicationRecord
  belongs_to :tags
  belongs_to :nfts, foreign_key: :fingerprint
end
