module Api
  module V1
    class ConfirmationsController < Devise::ConfirmationsController
      skip_before_action :authenticate_api_user!

      protected

      def after_confirmation_path_for(_resource_name, _resource)
        ENV.fetch('PUBWEAVE_BASE_URL')
      end
    end
  end
end
