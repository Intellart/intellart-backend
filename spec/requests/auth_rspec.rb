require 'rails_helper'

describe 'AUTH', type: :request do
  context 'User registration -' do
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

  context 'User login -' do
    it 'non existent user should not be found' do
      post '/api/v1/auth/session', params: { user: { email: 'non-existant@test.com', password: '123456' } }

      expect(response).to have_http_status(:not_found)
    end

    it 'wrong password should return unathorized' do
      post '/api/v1/auth/session', params: { user: { email: 'test@test.com', password: '1' } }

      expect(response.body).to eq({"errors":["Invalid password."]}.to_json)
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'test user should login successfully' do
      post '/api/v1/auth/session', params: { user: { email: 'test@test.com', password: '123456' } }

      expect(response).to have_http_status(:ok)
    end
  end

  # context 'User ORCID login -' do
  #   it '' do
  #     post '/api/v1/auth/session', params: { user: { email: 'non-existant@test.com', password: '123456' } }

  #     expect(response).to have_http_status(:not_found)
  #   end
  # end
end
