class Admins::SessionsController < Devise::SessionsController
  def new
  end

  protected

  def after_sign_in_path_for(resource)
    dashboard_admins_path
  end
end
