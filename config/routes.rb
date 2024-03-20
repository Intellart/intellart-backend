Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: 'api/v1/confirmations',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_for :admins, defaults: { format: :json }

  intellart_routes = lambda do
    mount ActionCable.server => '/cable'

    resources :nfts do
      member do
        put :accept_minting
        put :reject_minting
        put :update_tx_and_witness
        put :update_seller
        put :check_sale_status
        put :check_buy_status
      end
      collection do
        get :index_mint_request
        get :index_minted
        get :index_on_sale
        get :index_user_nfts
      end
    end
    resources :nft_likes, only: [:index, :create, :destroy]
    resources :users, only: [:show, :index, :update, :destroy] do
      collection do
        get :reviewers
      end
    end
    get '/exchange_rates', to: 'exchange_rates#latest'
    get '/categories', to: 'categories#index'
    get '/study_fields', to: 'study_fields#index'
    get '/nft_collections', to: 'nft_collections#index'
    get '/generate_nft', to: 'python#generate_nft'
    get '/sd_search/scopus', to: 'science_direct#search_scopus'
    get '/sd_search/scopus/author', to: 'science_direct#search_scopus_author'
    get '/sd_search/scopus/affiliation', to: 'science_direct#search_scopus_affiliation'
    get '/blockfrost/query_asset', to: 'blockfrost#query_asset'
    get '/blockfrost/query_address', to: 'blockfrost#query_address_for_asset'
  end

  # PUBWEAVE
  pubweave_routes = lambda do
    resources :articles do
      member do
        put :accept_publishing
        put :add_collaborator
        post :add_tag
        put :convert
        put :like
        put :reject_publishing
        put :remove_tag
        put :request_publishing
        put :unlock_article
      end
    end
    resources :comments, only: [:create, :destroy] do
      member do
        put :dislike
        put :like
      end
    end
    resources :sections, param: :editor_section_id do
      member do
        get :version_data
        put :lock
        put :unlock
      end
    end
    resources :uploads do
      collection do
        post :upload_asset
      end
    end
    resources :user_reviews do
      member do
        put :accept_review
        put :reject_review
      end
    end
    resources :reviews
    get '/status_preprints', to: 'preprints#index_by_status'
    post '/cardanoops/treasury_fill_build_tx', to: 'cardanoops#treasury_fill_build_tx'
    post '/cardanoops/treasury_fill_submit_tx', to: 'cardanoops#treasury_fill_submit_tx'
    post '/cardanoops/treasury_spend_build_tx', to: 'cardanoops#treasury_spend_build_tx'
    post '/cardanoops/treasury_spend_submit_tx', to: 'cardanoops#treasury_spend_submit_tx'
  end

  namespace :api, defaults: { format: :json } do
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

      namespace :intellart, &intellart_routes
      namespace :pubweave, &pubweave_routes

      resources :categories
      resources :tags
    end
  end
end
