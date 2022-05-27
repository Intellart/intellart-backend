class ExchangeRate < ApplicationRecord
  validates :unix_time, :coin_id, :usd, :cad, :eur, :gbp, presence: true
  validates :unix_time, uniqueness: true

  after_create :exchange_rate_broadcast

  private

  def exchange_rate_broadcast
    ActionCable.server.broadcast('general_channel', {
      type: 'exchange_rates',
      data: self
    })
  end
end
