#Rails.application.config.hosts << /.*\.(intellart)\.com/

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  require 'dotenv/load'

  allow do
    # origins '*'
    origins [ENV.fetch('FRONTEND_BASE_URL', 'http://localhost:3001'), ENV.fetch('FRONTEND_WS_URL', 'ws://localhost:3001')]
    # origins ['https://pubweave.intellart.ca', 'wss://pubweave.intellart.ca', 'https://veritheum.intellart.ca', 'wss://veritheum.intellart.ca']
    resource '*',
             expose: %w[Authorization _jwt],
             headers: :any,
             methods: %i[get post put patch delete head options]
  end
end
