require 'rails_helper'

RSpec.describe OrcidService, type: :service do
  describe OrcidService::OrcidOAuthApi do
    it 'should return correct sandbox url' do
      uri = OrcidService::OrcidOAuthApi.base_uri

      expect(uri).to eq('https://sandbox.orcid.org')
    end
  end

  describe OrcidService::OrcidApi do
    it 'should return correct sandbox url' do
      uri = OrcidService::OrcidApi.base_uri

      expect(uri).to eq('https://pub.sandbox.orcid.org/v3.0')
    end
  end
end
