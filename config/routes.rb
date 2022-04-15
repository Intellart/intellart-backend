Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }, skip: [:registrations]

  resources :admins, only: [] do
    collection do
      get :dashboard
    end
  end

  root to: 'home#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }

  resources :users do
    collection do
      get :index
    end
  end
end
