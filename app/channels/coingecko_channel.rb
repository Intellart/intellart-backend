class CoingeckoChannel < ApplicationCable::Channel
  def subscribed
    #stream_from "testing_channel_user_#{@current_user.id}"
  end

  def adausd
    0.57
  end
end
