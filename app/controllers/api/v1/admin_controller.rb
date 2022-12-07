module Api
  module V1
    class AdminController < ApplicationController
      skip_before_action :authenticate_api_user!, only: [:create_session]
      after_action :make_header_jwt, only: [:create_session]

      # POST /api/admin/session
      def create_session
        @admin = Admin.find_by_email(admin_session_params[:email])
        render_json_error :not_found, :admin_not_found and return unless @admin

        if @admin&.valid_password?(admin_session_params[:password])
          @domain = admin_session_params[:domain]
          @jwt = AuthTokenService.generate_jwt(@admin.id, @domain, admin: true)
          @current_user = @admin
          render json: @admin, status: :ok
        else
          render json: { errors: ['Invalid password.'] }, status: :unprocessable_entity
        end
      end

      # DELETE /api/admin/session
      def destroy_session
        token, = token_and_options(request)
        AuthTokenService.save_expired_token(token)
        @current_user = nil
        head :no_content
      end

      private

      def admin_session_params
        params.require(:admin).permit(:email, :password, :domain)
      end
    end
  end
end
