Rails.application.routes.draw do
  # resources :admins, only: [] do
  #   collection do
  #     get :dashboard
  #   end
  # end

  # TODO: devise must have current_user for email confirmation link
  devise_for :users, controllers: {
    confirmations: 'api/v1/confirmations',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  current_api_routes = lambda do
    resources :nfts
    resources :users, only: [:show, :update, :destroy]
    get '/study_fields', to: 'study_fields#index'
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1, &current_api_routes
    namespace :v1 do
      post '/auth/user', to: 'auth#create_user'
      put '/auth/user/password_update', to: 'passwords#update'
      post '/auth/session', to: 'auth#create_session'
      post '/auth/orcid', to: 'auth#auth_orcid'
      post '/auth/user/orcid', to: 'auth#create_user_orcid'
      post '/auth/session/orcid', to: 'auth#create_session_orcid'
      delete '/auth/session', to: 'auth#destroy_session'

      # TODO: write this method
      post '/auth/validate_jwt', to: 'auth#validate_jwt'
    end
  end
end
