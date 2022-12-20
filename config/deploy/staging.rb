server '161.97.171.245:42022', user: 'deploy', roles: %w[web app db]
set ssh_options: {
  user: 'deploy', # overrides user setting above
  keys: %w[/home/deploy/.ssh/leon_key /home/deploy/.ssh/dominik_key /home/deploy/.ssh/filip_key],
  forward_agent: false,
  auth_methods: %w[publickey password]
}
set :stage, :staging
set :branch, :lk_admin_login
set :rails_env, 'staging'
