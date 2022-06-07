require 'rails_helper'

RSpec.describe 'NFTs', type: :request do
  let!(:study_field) { FactoryBot.create(:study_field) }
  let!(:user) { FactoryBot.create(:user, study_field_id: study_field.id) }
  let!(:user2) { FactoryBot.create(:user, email: 'test2@test.com', orcid_id: '0000-0000-0000-0002', study_field_id: study_field.id) }
  let!(:rating) { FactoryBot.create(:rating, user: user, rated_user_id: user2.id) }
  let!(:wallet) { FactoryBot.create(:wallet, user: user) }
  let!(:wallet2) { FactoryBot.create(:wallet, user: user2) }
  let!(:onchain_tx) { FactoryBot.create(:onchain_transaction) }
  let!(:cardano_addr) { FactoryBot.create(:cardano_address, wallet: wallet) }
  let!(:category) { FactoryBot.create(:category) }
  let!(:nft_coll) { FactoryBot.create(:nft_collection) }
  let!(:tag) { FactoryBot.create(:tag) }
  let!(:nft) { FactoryBot.create(:nft, owner_id: user.id, category_id: category.id, nft_collection_id: nft_coll.id, cardano_address_id: cardano_addr.id, onchain_transaction_id: onchain_tx.id) }
  let!(:nft_tag) { FactoryBot.create(:nft_tag, user_id: user.id, tag_id: tag.id) }
  let!(:nft_like) { FactoryBot.create(:nft_like, user_id: user.id) }
  let!(:nft_endorser) { FactoryBot.create(:nft_endorser, user_id: user.id) }

  before :each do
    @test_nft = {
      tradeable: true,
      price: 100.00000000,
      name: 'Mandala Sovereigns 4024',
      description: 'test-description',
      subject: 'test-subject',
      owner_id: user.id,
      category_id: category.id,
      nft_collection_id: nft_coll.id,
      asset_name: 'lion00024',
      policy_id: '8001dede26bb7cbbe4ee5eae6568e763422e0a3c776b3f70878b03f1',
      fingerprint: 'asset1hr5j2pulx3273er0dpcz9yu6xzeuypsc9nq2az',
      onchain_transaction_id: onchain_tx.id,
      cardano_address_id: cardano_addr.id
    }

    # Login user
    post '/api/v1/auth/session', params: { user: { email: 'test@test.com', password: '123456' } }
    @jwt = response.headers['_jwt']
    @headers = { 'Authorization' => "Bearer #{@jwt}" }
  end

  describe 'creation - ' do
    it 'User that is not logged in should not be able to create NFTs' do
      post '/api/v1/nfts', params: { nft: @test_nft }

      expect(response.body).to eq({"errors"=>["Nil JSON web token"]}.to_json)
      expect(response).to have_http_status(:unauthorized)
    end

    it 'User logged in should be able to create NFTs' do
      expect {
        post '/api/v1/nfts', params: { nft: @test_nft }, headers: @headers
      }.to change(Nft, :count)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'deletion - ' do
    it 'User that is not logged in should not be able to delete NFTs' do
      delete api_v1_nft_path(nft.id), params: { id: nft.fingerprint }

      expect(response.body).to eq({"errors"=>["Nil JSON web token"]}.to_json)
      expect(response).to have_http_status(:unauthorized)
    end

    it 'User logged in should be able to delete NFTs' do
      delete api_v1_nft_path(nft.id), params: { id: nft.fingerprint }, headers: @headers

      expect(Nft.count).to eq(0)
      expect(response).to have_http_status(:no_content)
    end
  end
end
