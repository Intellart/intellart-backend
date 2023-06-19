module Broadcastable
  def broadcast(channel, type, method, data, states = nil)
    payload = {
      type: type,
      method: method,
      data: data || data.object
    }
    payload[:states] = states if states.present?
    ActionCable.server.broadcast(
      channel,
      payload
    )
  end
end
