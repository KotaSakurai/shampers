Rails.application.routes.draw do
  get 'sessions/new'

  get 'users/index'
  root 'users#index'

  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/account_activations/:id/edit', to: 'account_activations#edit'
  resources :users
  resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
