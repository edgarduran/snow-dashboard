Rails.application.routes.draw do

  get 'test/index'

  get 'resorts/index'

  get '/', to: 'landing#index'
  get '/auth/google_oauth2', as: :login
  get '/auth/google_oauth2/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :dashboard, only: [:index]
  resources :resorts,   only: [:index, :create, :destroy]
  resources :sessions,  only: [:edit, :update]
  resources :test,  only: [:index]

end
