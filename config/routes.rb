Rails.application.routes.draw do
  get 'search_tags/index'

  get 'sessions/new'

  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :shampoos
  resources :tags, only: [:new, :create, :destroy]
  resources :searchtags
  root 'shampoos#index'
end
