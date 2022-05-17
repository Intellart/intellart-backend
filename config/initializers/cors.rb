#Rails.application.config.hosts << /.*\.(intellart)\.com/

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  require 'dotenv/load'

  allow do
    origins '*'
    # origins [ENV.fetch('FRONTEND_BASE_URL', 'http://localhost:3001')]
    resource '*',
             expose: %w[Authorization _jwt],
             headers: :any,
             methods: %i[get post put patch delete head options]
  end
end
