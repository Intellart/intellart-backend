require 'rails_helper'

RSpec.describe GetCurrentExchangeRatesJob do
  describe 'perform job', :vcr do
    it 'should get and save latest ADA exchange rates' do
      respond_to GetCurrentExchangeRatesJob.perform_now do
        expect(response).to have_http_status(:success)
      end

      latest = ExchangeRate.first
      expect(latest).to_not eq(nil)
    end
  end
end
