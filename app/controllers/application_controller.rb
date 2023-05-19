class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token
  require 'dotenv/load'

  respond_to :json
  before_action :authenticate_api_user!
  skip_before_action :verify_authenticity_token
  before_action :set_paper_trail_whodunnit

  helper_method :render_json_error, :render_json_validation_error, :unauthorized!, :authenticate_api_user!, :authenticate_domain

  private

  # AUTH
  def make_header_jwt
    response.set_header('_jwt', @jwt)
  end

  def refresh_jwt
    is_admin = @current_user.class.name == 'Admin'
    new_token = AuthTokenService.generate_jwt(@current_user.id, @domain, admin: is_admin)
    response.set_header('_jwt', new_token)
  end

  def authenticate_api_user!
    token, = token_and_options(request)
    unauthorized! unless jwt_valid?(token) && !jwt_expired?(token)
  end

  def authenticate_api_admin!
    authenticate_api_user!
    unauthorized! unless @current_user.super?
  rescue NoMethodError
    unauthorized!
  end

  def authenticate_domain
    token, = token_and_options(request)
    payload = AuthTokenService.decode_jwt(token)
    head :unauthorized unless payload[0]['domain'] == @domain
  end

  def jwt_valid?(token)
    jwt_payload = AuthTokenService.decode_jwt(token)
    @domain = jwt_payload[0]['domain']

    if jwt_payload[0]['admin_id']
      user_id = jwt_payload[0]['admin_id']
      @current_user = Admin.find(user_id)
    else
      user_id = jwt_payload[0]['user_id']
      @current_user = User.find(user_id)
    end
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
