class Api::V1::StudyFieldsController < ApplicationController
  after_action :refresh_jwt

  rescue_from ActiveRecord::RecordNotFound do
    render_json_error :not_found, :study_fields_not_found
  end

  def index
    study_fields = StudyField.all
    render json: study_fields, status: :ok
  end
end
