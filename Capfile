require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/rbenv'
require 'capistrano/puma'
require 'capistrano/rails/migrations'
require 'capistrano/passenger'
require 'capistrano/rails/collection'
require 'capistrano/figaro_yml'
set :rbenv_type, :user
set :rbenv_ruby, '3.0.2'
install_plugin Capistrano::Puma
set :linked_files, %w[.env]
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
