Rails.application.routes.draw do

  # resources :admins, only: [] do
  #   collection do
  #     get :dashboard
  #   end
  # end

  # TODO: devise must have current_user for email confirmation link
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  current_api_routes = lambda do
    resources :nfts
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1, &current_api_routes
    namespace :v1 do
      post '/auth/user', to: 'auth#create_user'
      post '/auth/session', to: 'auth#create_session'
      delete '/auth/session', to: 'auth#destroy_session'
    end
  end
end
