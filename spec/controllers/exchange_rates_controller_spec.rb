require 'rails_helper'

RSpec.describe Api::V1::ExchangeRatesController, type: :controller do
  describe 'GET latest', :vcr do
    it 'returns latest exchange rates' do
      GetCurrentExchangeRatesJob.perform_now

      get :latest

      parsed = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(parsed).to have_key('unix_time')
      expect(parsed).to have_key('coin_id')
      expect(parsed).to have_key('usd')
      expect(parsed).to have_key('gbp')
      expect(parsed).to have_key('cad')
      expect(parsed).to have_key('eur')
    end
  end
end
