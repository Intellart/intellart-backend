class Wallet < ApplicationRecord
  belongs_to :user
  has_many :cardano_addresses

  def active_model_serializer
    WalletSerializer
  end

  def total
    cardano_addresses.count
  end

  def used
    cardano_addresses.where(dirty: true).count
  end
end
