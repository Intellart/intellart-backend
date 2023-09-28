#Rails.application.config.hosts << /.*\.(intellart)\.ca/

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  require 'dotenv/load'

  allow do
    # origins '*'
    # origins [ENV.fetch('FRONTEND_BASE_URL', 'http://localhost:3001'), ENV.fetch('FRONTEND_WS_URL', 'ws://localhost:3001')]
    origins [
      ENV.fetch('VERITHEUM_BASE_URL', 'http://localhost:3001'),
      ENV.fetch('PUBWEAVE_BASE_URL', 'http://localhost:3002'),
      ENV.fetch('VERITHEUM_WS_URL', 'ws://localhost:3001'),
      ENV.fetch('PUBWEAVE_WS_URL', 'ws://localhost:3002')
    ]
    resource '*',
             expose: %w[Authorization _jwt],
             headers: :any,
             methods: %i[get post put patch delete head options]
  end
end
