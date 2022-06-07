require 'rails_helper'
require 'dotenv/load'

API_KEY = ENV.fetch('API_KEY')
ALGORITHM_TYPE = ENV.fetch('ALGORITHM_TYPE')

RSpec.describe AuthTokenService, type: :service do
  describe 'Generate JWT' do
    it 'encodes user_id into JWT' do
      test_jwt = AuthTokenService.generate_jwt(user_id = 1)

      payload = { user_id: 1, exp: 30.minutes.from_now.to_i }
      encoded_jwt = JWT.encode payload, API_KEY, ALGORITHM_TYPE

      expect(test_jwt).to eq(encoded_jwt)
    end

    it 'decodes jwt and returns payload with user_id' do
      test_jwt = AuthTokenService.generate_jwt(user_id = 1)

      decoded = AuthTokenService.decode_jwt(token = test_jwt)

      expect(decoded[0]).to have_key('user_id')
      expect(decoded[0]['user_id']).to eq(1)
    end

    it 'saves expired jwt into the db table jwt_denylist' do
      test_jwt = AuthTokenService.generate_jwt(user_id = 1)

      AuthTokenService.save_expired_token(token = test_jwt)

      expired = JwtDenylist.first
      expect(expired).to_not eq(nil)
    end
  end
end
