require 'rails_helper'

RSpec.describe CoingeckoService, type: :service do
  describe 'get url' do
    it 'should return correct Coingecko API url' do
      uri = CoingeckoService.base_uri

      expect(uri).to eq('https://api.coingecko.com/api/v3')
    end
  end
end
