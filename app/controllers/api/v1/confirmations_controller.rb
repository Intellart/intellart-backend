module Api
  module V1
    class ConfirmationsController < Devise::ConfirmationsController
      skip_before_action :authenticate_api_user!

      def show
        token = params.require(:confirmation_token)

        if token
          user = User.find_by(confirmation_token: token)
          if user
            # Proceed with confirmation
            user.confirm
            render json: { userID: user.id }, status: :ok
          else
            render json: { error: 'Invalid token' }, status: :unprocessable_entity
          end
        else
          render json: { error: 'Missing confirmation token' }, status: :unprocessable_entity
        end
      end

      protected

      def after_confirmation_path_for(_resource_name, _resource)
        ENV.fetch('PUBWEAVE_BASE_URL')
      end
    end
  end
end
