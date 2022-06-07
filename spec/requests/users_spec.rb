require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe 'Users', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user, email: 'test2@test.com', orcid_id: '0000-0000-0000-0002') }

  before :each do
    # Login user
    login_user(email = 'test@test.com', password = '123456')
  end

  describe 'Update profile -' do
    it 'missing fields should not update user data' do
      put api_v1_user_path(user.id), params: { user: { first_name: nil } }, headers: @headers

      expect(response).to have_http_status(:bad_request)
    end

    it 'should update user data' do
      put api_v1_user_path(user.id), params: { user: { first_name: 'Updated', last_name: 'Name', orcid_id: '1000' } }, headers: @headers

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Updated')
    end
  end

  describe 'Update password -' do
    # TODO: check why this is test is failing
    it 'wrong user should not be able to update other users password' do
      # logout previous user
      delete api_v1_auth_session_path, headers: @headers

      # Login user2
      login_user(email = 'test2@test.com', password = '123456')

      put api_v1_auth_user_password_update_path(user.id), params: { password: { password: 'abcdef' } }, headers: @headers

      expect(response).to have_http_status(:unauthorized)
    end

    it 'user should be able to update password' do
      put api_v1_auth_user_password_update_path(user.id), params: { password: { password: 'abcdefgh' } }, headers: @headers

      expect(response).to have_http_status(:ok)
    end
  end
end
