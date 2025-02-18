module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :authenticate_api_user!, only: [:create_session, :create_user, :create_orcid_session, :create_user_orcid, :auth_orcid]
      after_action :make_header_jwt, only: [:create_session, :create_orcid_session]

      rescue_from ActiveRecord::RecordNotFound do
        render_json_error :not_found, :user_not_found
      end

      ORCID_CLIENT_ID = ENV.fetch('ORCID_CLIENT_ID')
      ORCID_SECRET = ENV.fetch('ORCID_SECRET')

      # POST /api/auth/session
      def create_session
        @user = User.find_by_email(user_session_params[:email])
        render_json_error :not_found, :user_not_found and return unless @user

        if @user&.valid_password?(user_session_params[:password])
          domain = user_session_params[:domain]
          @jwt = AuthTokenService.generate_jwt(@user.id, domain)
          render json: @user, status: :ok
        else
          render json: { errors: ['Invalid password.'] }, status: :unprocessable_entity
        end
      end

      # POST /api/auth/session/orcid
      def create_orcid_session
        @user = User.find_by(orcid_id: user_orcid_params[:orcid])
        render_json_error :not_found, :user_not_found and return unless @user

        domain = user_orcid_params[:domain]
        @jwt = AuthTokenService.generate_jwt(@user.id, domain)
        render json: @user, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { errors: ['Invalid ORCID Id.'] }, status: :unprocessable_entity
      end

      # POST /api/auth/user
      def create_user
        @user = User.new(user_create_params)
        render_json_validation_error(@user) and return unless @user.save

        render json: @user, status: :ok
      end

      # POST /api/auth/user/orcid
      def create_orcid_user
        response = OrcidService::OrcidApi.get(
          "/#{user_orcid_params[:orcid]}/record",
          headers: {
            "Authorization": "Bearer #{user_orcid_params[:access_token]}",
            "Content-Type": 'application/orcid+json'
          }
        ).parsed_response

        return unless response

        render json: JSON.parse(response), status: :ok and return unless response['error']

        render json: { errors: [response['error_description']] }, status: :bad_request
      end

      # POST /api/auth/orcid
      def auth_orcid
        response = OrcidService::OrcidOAuthApi.post(
          '/oauth/token',
          body: {
            client_id: ORCID_CLIENT_ID,
            client_secret: ORCID_SECRET,
            grant_type: 'authorization_code',
            redirect_uri: auth_orcid_params[:redirect_uri],
            code: auth_orcid_params[:code]
          }
        ).parsed_response

        return unless response

        render json: { orcid: response }, status: :ok and return if response['orcid'] && !response['error']

        render json: { errors: [response['error_description']] }, status: :bad_request
      end

      # DELETE /api/auth/session
      def destroy_session
        token, = token_and_options(request)
        AuthTokenService.save_expired_token(token)
        head :no_content
      end

      # POST /api/auth/validate_jwt
      def validate_jwt
        token = params[:jwt]
        jwt_payload = AuthTokenService.decode_jwt(token)
        is_admin = false
        if jwt_payload[0]['admin_id']
          user_id = jwt_payload[0]['admin_id']
          user = Admin.find(user_id)
          is_admin = true
        else
          user_id = jwt_payload[0]['user_id']
          user = User.find(user_id)
        end
        head :unauthorized and return unless user == @current_user && !jwt_expired?(token)

        render json: { user: is_admin ? AdminSerializer.new(user) : UserSerializer.new(user), is_admin: is_admin }, status: :ok
      rescue JWT::VerificationError, JWT::DecodeError
        head :unauthorized and return
      end

      private

      def user_session_params
        params.require(:user).permit(:email, :password, :domain)
      end

      def user_create_params
        params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :study_field_id, :orcid_id, :domain)
      end

      def auth_orcid_params
        params.require(:orcid).permit(:code, :redirect_uri)
      end

      def user_orcid_params
        params.require(:orcid).permit(:access_token, :token_type, :refresh_token, :expires_in, :scope, :name, :orcid)
      end
    end
  end
end
