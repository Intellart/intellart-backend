Rails.application.routes.draw do
  # TODO: devise must have current_user for email confirmation link
  devise_for :users, controllers: {
    confirmations: 'api/v1/confirmations',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_for :admins, defaults: { format: :json }

  current_api_routes = lambda do
    mount ActionCable.server => '/cable'

    resources :nfts do
      member do
        put :accept_minting
        put :reject_minting
        put :sell_request
        put :accept_sell
        put :reject_sell
      end
      collection do
        get :nfts_sell_requests
      end
    end
    resources :nft_likes, only: [:index, :create, :destroy]
    resources :users, only: [:show, :index, :update, :destroy]
    get '/exchange_rates', to: 'exchange_rates#latest'
    get '/categories', to: 'categories#index'
    get '/study_fields', to: 'study_fields#index'
    get '/nft_collections', to: 'nft_collections#index'
    get '/generate_nft', to: 'python#generate_nft'
    get '/sd_search/scopus', to: 'science_direct#search_scopus'
    get '/sd_search/scopus/author', to: 'science_direct#search_scopus_author'
    get '/sd_search/scopus/affiliation', to: 'science_direct#search_scopus_affiliation'
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1, &current_api_routes
    namespace :v1 do
      post '/auth/user', to: 'auth#create_user'
      put '/auth/user/password_update', to: 'passwords#update'
      post '/auth/session', to: 'auth#create_session'
      post '/auth/orcid', to: 'auth#auth_orcid'
      post '/auth/orcid/user', to: 'auth#create_orcid_user'
      post '/auth/orcid/session', to: 'auth#create_orcid_session'
      delete '/auth/session', to: 'auth#destroy_session'
      post '/auth/validate_jwt', to: 'auth#validate_jwt'
      post '/admin/session', to: 'admin#create_session'
      delete '/admin/session', to: 'admin#destroy_session'
    end
  end
end
