# config valid for current version and patch releases of Capistrano
lock "~> 3.17.1"

require 'capistrano-db-tasks'

#FIXME add your app name here
set :application, 'intellart-be-staging'
#FIXME replace 'git@github.com:YOUR-GIT-REPO-HERE' with your git clone url
set :repo_url, 'git@github.com:Intellart/intellart-backend.git'
#FIXME add location on the server here
set :deploy_to, '/home/deploy/intellart-be'
set :branch, :lk_capistrano_gem

set :linked_files, %w{config/database.yml config/master.key}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :keep_releases, 3

set :db_local_clean, true
set :db_remote_clean, true
set :passenger_restart_with_touch, true

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end
