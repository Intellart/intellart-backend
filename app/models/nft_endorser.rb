class NftEndorser < ApplicationRecord
  belongs_to :users
  belongs_to :nfts, foreign_key: :fingerprint
end
