class AdminsController < ApplicationController
  before_action :authenticate_super_admin!
  layout 'admin'

  def dashboard
    respond_to do |format|
      format.json do
        render json: {}, status: 200
      end
      format.html do
      end
    end
  end
end
