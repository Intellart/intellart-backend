class Api::V1::ExchangeRatesController < ApplicationController
  skip_before_action :authenticate_api_user!

  rescue_from ActiveRecord::RecordNotFound do
    render_json_error :not_found, :exchange_rate_not_found
  end

  def latest
    exchange_rate = ExchangeRate.last
    render json: exchange_rate, status: :ok
  end
end