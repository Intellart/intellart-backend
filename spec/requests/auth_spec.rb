require 'rails_helper'

RSpec.describe 'AUTH', type: :request do
  let!(:orcid_id) { '0000-0001-9349-4019' }
  let!(:orcid_id_2) { '0001-0001-9349-4019' }
  let!(:access_token) { 'bf2729b2-dc4b-496c-be3b-6b2a07019cd6' }
  let!(:user) { FactoryBot.create(:user) }
  let!(:thespian_user) { FactoryBot.create(:user, email: 'thespian-agency@thespian.hr', orcid_id: orcid_id) }

  describe 'Registration -' do
    it 'missing fields should return errors' do
      post '/api/v1/auth/user', params: { user: { email: 'test3@test.com', first_name: '', last_name: 'Last', password: '123456', orcid_id: '1000' } }

      expect(response.body).to eq({"errors"=>["First name can't be blank"]}.to_json)
      expect(response).to have_http_status(:bad_request)
    end

    it 'registration should be a success' do
      post '/api/v1/auth/user', params: { user: { email: 'test3@test.com', first_name: 'First', last_name: 'Last', password: '123456', orcid_id: '1000' } }

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'Login -' do
    it 'non existent user should not be found' do
      post '/api/v1/auth/session', params: { user: { email: 'non-existant@test.com', password: '123456' } }

      expect(response).to have_http_status(:not_found)
    end

    it 'wrong password should return unauthorized' do
      post '/api/v1/auth/session', params: { user: { email: 'test@test.com', password: '1' } }

      expect(response.body).to eq({"errors":["Invalid password."]}.to_json)
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'test user should login and logout successfully, jwt should be expired' do
      post '/api/v1/auth/session', params: { user: { email: 'test@test.com', password: '123456' } }

      expect(response).to have_http_status(:ok)
      expect(response.headers["_jwt"]).to_not eq(nil)
      @jwt = response.headers["_jwt"]

      headers = { "Authorization" => "Bearer #{@jwt}" }

      delete '/api/v1/auth/session', headers: headers
      last_jwt = JwtDenylist.last&.jti

      expect(response).to have_http_status(:no_content)
      expect(last_jwt).to eq(@jwt)
    end
  end

  describe 'ORCID login', :vcr do
    it 'OAUTH returns a valid response' do
      post '/api/v1/auth/orcid', params: { orcid: { code: 'lR87O2', redirect_uri: 'http://localhost:3001/sign_in' } }

      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(parsed_response).to have_key('orcid')
      expect(parsed_response['orcid']['orcid']).to have_key('access_token')
    end

    it 'OAUTH returns an invalid response' do
      post '/api/v1/auth/orcid', params: { orcid: { code: '', redirect_uri: 'http://localhost:3001/sign_in' } }

      expect(response).to have_http_status(:unauthorized)
    end

    it 'ORCID record exists' do
      post '/api/v1/auth/orcid/user', params: { orcid: { access_token: access_token, orcid: orcid_id } }
      parsed_response = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(parsed_response).to have_key('email')
      expect(parsed_response).to have_key('orcid_id')
    end

    it 'ORCID access token is invalid' do
      post '/api/v1/auth/orcid/user', params: { orcid: { access_token: 'zzzzzz', orcid: orcid_id } }

      expect(response).to have_http_status(:unauthorized)
    end

    it 'ORCID record does not exist' do
      post '/api/v1/auth/orcid/user', params: { orcid: { access_token: access_token, orcid: '9999-0001-9349-4019' } }

      expect(response).to have_http_status(:bad_request)
    end

    it 'with ORCID ID successfull' do
      post '/api/v1/auth/orcid/session', params: { orcid: { orcid: orcid_id } }

      expect(response).to have_http_status(:ok)
      expect(response.headers).to have_key('_jwt')
      expect(JSON.parse(response.body)).to have_key('email')
    end

    it 'ORCID ID not found in the database' do
      post '/api/v1/auth/orcid/session', params: { orcid: { orcid: orcid_id_2 } }

      expect(response).to have_http_status(:not_found)
    end
  end
end
