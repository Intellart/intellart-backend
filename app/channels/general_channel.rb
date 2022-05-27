class GeneralChannel < ActionCable::Channel::Base
  def subscribed
    stream_from 'general_channel'

    exchange_rate = ExchangeRate.last
    ActionCable.server.broadcast('general_channel', {
      type: 'exchange_rates',
      data: exchange_rate
    })
  end

  def unsubscribed
  end
end
