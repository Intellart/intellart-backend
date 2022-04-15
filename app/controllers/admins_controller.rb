class AdminsController < ApplicationController
  before_action :authenticate_super_admin!
  layout 'admin'

  def dashboard
    respond_to do |format|
      format.html {}
      format.json { render json: { status: 200 } }
    end
  end
end
