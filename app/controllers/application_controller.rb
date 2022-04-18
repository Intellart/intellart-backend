class ApplicationController < ActionController::Base
  require 'dotenv/load'
  # before_action :authenticate_user!
  # before_action :configure_permitted_parameters, if: :devise_controller?
  # helper_method :logged_in?, :is_valid?, :authorize!
  API_KEY = ENV.fetch('API_KEY')

  def authenticate_super_admin!
    authenticate_admin!
    return true if current_admin.super?

    flash[:alert] = 'You are not authorized to access this part of the admin dashboard.'
    redirect_to root_path
  end

  private

  def after_sign_in_path_for(resource)
    if resource.instance_of? Admin
      root_path
    else
      root_path
    end
  end

  # API AUTHORIZATION
  def is_valid?
    if !request.headers["Authorization"] || (request.headers["Authorization"] && API_KEY != request.headers["Authorization"].sub("Bearer ", ""))
      render :json => { errors: ["Access denied due to missing/invalid subscription key. Make sure to include the correct subscription key when making requests to an API."] }, status: :unauthorized
    end
  end

  def authorize?
    request.headers['Authorization'] = "Bearer #{API_KEY}"
  end

  # HELPERS
  def logged_in?
    # make it into a boolean
    !!current_user
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :orcid_id])
  end
end
