source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'aasm', '~> 5.4'
gem 'capistrano',         require: false
gem 'capistrano3-puma',   require: false
gem 'capistrano-bundler', require: false
gem 'capistrano-db-tasks', require: false
gem 'capistrano-figaro-yml'
gem 'capistrano-passenger'
gem 'capistrano-rails', require: false
gem 'capistrano-rails-collection'
gem 'capistrano-rails-console', require: false
gem 'capistrano-rbenv', require: false
gem 'capistrano-rbenv-install', require: false
gem 'cloudinary', '~> 1.2', '>= 1.2.2'

gem 'bcrypt_pbkdf', '>= 1.0'
gem 'ed25519', '>= 1.2'
gem 'figaro'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 7.0.0'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
gem 'redis', '< 4.6'

gem 'active_model_serializers', require: true
gem 'devise'
gem 'dotenv'
gem 'elsevier_api'
gem 'good_job'
gem 'http', '5.0.4'
gem 'httparty'
gem 'jwt'
gem 'paper_trail'
gem 'paper_trail-globalid'
gem 'rack-cors'
gem 'shorturl'
gem 'sidekiq', '6.2.2'
gem 'sidekiq-scheduler', '3.1.0'
gem 'webmock'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'factory_bot_rails'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'vcr'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  # Test coverage
  gem 'simplecov', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
