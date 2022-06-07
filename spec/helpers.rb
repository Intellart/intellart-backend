module Helpers
  def login_user(email, password)
    post '/api/v1/auth/session', params: { user: { email: email, password: password } }
    @jwt = response.headers['_jwt']
    @headers = { 'Authorization' => "Bearer #{@jwt}" }
  end
end
