module Api
  module V1
    module Intellart
      class StudyFieldsController < ApplicationController
        skip_before_action :authenticate_api_user!, only: [:index]

        rescue_from ActiveRecord::RecordNotFound do
          render_json_error :not_found, :study_fields_not_found
        end

        def index
          study_fields = StudyField.all
          render json: study_fields, status: :ok
        end
      end
    end
  end
end
