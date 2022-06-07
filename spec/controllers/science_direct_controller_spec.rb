require 'rails_helper'

RSpec.describe Api::V1::ScienceDirectController, type: :controller do
  describe 'GET /sd_search/scopus', :vcr do
    it 'returns search results from Scopus API' do
      get :search_scopus, params: { query: 'NFT Marketplace' }
      body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(body).to have_key('search-results')
    end
  end
end
