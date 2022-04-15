class Wallet < ApplicationRecord
  belongs_to :user
  has_many :cardano_addresses
end
