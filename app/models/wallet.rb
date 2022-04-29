class Wallet < ApplicationRecord
  belongs_to :user
  has_many :cardano_addresses

  def active_model_serializer
    WalletSerializer
  end
end
