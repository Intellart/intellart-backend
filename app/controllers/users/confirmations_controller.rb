class Users::ConfirmationsController < Devise::ConfirmationsController
  # The path used after confirmation.
  # User can now finally log in so we want to send them to the log in page at this point
  def after_confirmation_path_for(resource_name, resource)
    new_user_session_path
  end
end
