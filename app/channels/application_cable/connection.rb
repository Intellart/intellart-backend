# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      email = request.params[:id]
      unless email.present?
        reject_unauthorized_connection
        return
      end

      current_user = Admin.find_by_email(email) || User.find_by_email(email)
      if current_user.present?
        current_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
