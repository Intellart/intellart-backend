class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token
  require 'dotenv/load'
  before_action :authenticate_api_user!
  skip_before_action :verify_authenticity_token
  respond_to :json

  # def authenticate_super_admin!
  #   authenticate_admin!
  #   return true if current_admin.super?

  #   flash[:alert] = 'You are not authorized to access this part of the admin dashboard.'
  #   redirect_to root_path
  # end

  private

  def refresh_jwt
    new_token = AuthTokenService.generate_jwt(@current_user.id)
    response.set_header('_jwt', new_token)
  end

  def authenticate_api_user!
    token, = token_and_options(request)
    head :unauthorized unless jwt_valid?(token) && !jwt_expired?(token)
  end

  def jwt_valid?(token)
    jwt_payload = AuthTokenService.decode_jwt(token)
    user_id = jwt_payload[0]['user_id']
    @current_user = User.find(user_id)
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :unauthorized
  rescue JWT::DecodeError => e
    render json: { errors: e.message }, status: :unauthorized
  end

  def jwt_expired?(token)
    is_expired = JwtDenylist.find_by(jti: token)
    !!is_expired
  rescue ActiveRecord::RecordNotFound
    false
  end
end
