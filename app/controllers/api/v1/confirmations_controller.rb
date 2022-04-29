class Api::V1::ConfirmationsController < Devise::ConfirmationsController
  skip_before_action :authenticate_api_user!

  protected

  def after_confirmation_path_for(resource_name, resource)
    ENV.fetch('FRONTEND_BASE_URL')
  end
end
