Rails.application.routes.draw do

  get '/', to: 'landing#index'
  get '/auth/google_oauth2', as: :login
  get '/auth/google_oauth2/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :dashboard, only: [:index]

end
