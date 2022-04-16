Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }, skip: [:registrations]

  resources :admins, only: [] do
    collection do
      get :dashboard
    end
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
