module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    rescue_from ActiveRecord::RecordNotFound, JWT::DecodeError, JWT::VerificationError do
      render_unathorized_error
    end

    def connect
      token = request.params[:jwt] || nil
      payload = AuthTokenService.decode_jwt(token)
      puts payload
      user = User.find(payload[0]['user_id'])
      render :unauthorized and return unless user == @current_user && !jwt_expired?(token)

      self.current_user = user
    end
  end
end
