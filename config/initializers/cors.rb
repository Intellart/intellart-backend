#Rails.application.config.hosts << /.*\.(intellart)\.com/

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  require 'dotenv/load'
  FRONTEND_DEVELOPMENT = "http://localhost:#{ENV.fetch('FRONTEND_DEVELOPMENT_PORT', '3001')}"

  allow do
    # origins "*"
    origins [FRONTEND_DEVELOPMENT]
    resource '*',
             expose: ['Authorization'],
             headers: :any,
             methods: %i[get post put patch delete head options]
  end
end
