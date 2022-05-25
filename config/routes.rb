# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'landing#index'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  get '/login', to: 'users#login_auth'
  post '/login', to: 'sessions#create'
#  post '/users/:id', to: 'viewing_parties#create'
  delete '/logout', to: 'sessions#destroy'

  get '/dashboard/current_user', to: 'users#show'
  get '/dashboard/movies', to: 'movies#index'
  get '/dashboard/movies/:id', to: 'movies#show'
  get '/dashboard/movies/:id/new', to: 'viewing_parties#new'
  get '/dashboard/discover', to: 'discover#index'

  post '/dashboard', to: 'viewing_parties#create'

#  resources :users, only: %i[create] do
#    resources :movies, only: %i[index show] do
#      resources :viewing_parties, only: [:new]
#    end
#    resources :discover, only: [:index]
#  end
end
