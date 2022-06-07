class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token
  require 'dotenv/load'

  respond_to :json
  before_action :authenticate_api_user!
  skip_before_action :verify_authenticity_token

  helper_method :render_json_error, :render_json_validation_error, :unauthorized!

  # def authenticate_super_admin!
  #   authenticate_admin!
  #   return true if current_admin.super?

  #   flash[:alert] = 'You are not authorized to access this part of the admin dashboard.'
  #   redirect_to root_path
  # end

  private

  # AUTH
  def make_header_jwt
    response.set_header('_jwt', @jwt)
  end

  def refresh_jwt
    new_token = AuthTokenService.generate_jwt(@current_user.id)
    response.set_header('_jwt', new_token)
  end

  def authenticate_api_user!
    token, = token_and_options(request)
    unauthorized! unless jwt_valid?(token) && !jwt_expired?(token)
  end

  def jwt_valid?(token)
    jwt_payload = AuthTokenService.decode_jwt(token)
    user_id = jwt_payload[0]['user_id']
    @current_user = User.find(user_id)
  rescue ActiveRecord::RecordNotFound => e
    render_unathorized_error(e)
  rescue JWT::DecodeError => e
    render_unathorized_error(e)
  rescue JWT::VerificationError => e
    render_unathorized_error(e)
  end

  def jwt_expired?(token)
    is_expired = JwtDenylist.find_by(jti: token)
    !!is_expired
  rescue ActiveRecord::RecordNotFound
    false
  end

  # ERROR HANDLING
  def render_json_error(status, error_code, extra = {})
    status = Rack::Utils::SYMBOL_TO_STATUS_CODE[status] if status.is_a? Symbol

    error = {
      title: t("error_messages.#{error_code}.title"),
      status: status,
      code: t("error_messages.#{error_code}.code")
    }.merge(extra)

    detail = t("error_messages.#{error_code}.detail", default: '')
    error[:detail] = detail unless detail.empty?

    render json: { errors: [error] }, status: status
  end

  def render_json_validation_error(resource)
    render json: { errors: resource.errors.full_messages }, status: :bad_request
  end

  def render_unathorized_error(error = 'Unauthorized.')
    render json: { errors: [error.message] }, status: :unauthorized
  end

  def unauthorized!
    head :unauthorized
  end
end
