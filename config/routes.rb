# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'landing#index'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  get '/login', to: 'users#login_auth'
  post '/login', to: 'sessions#create'
  post '/users/:id', to: 'viewing_parties#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only: %i[show create] do
    resources :movies, only: %i[index show] do
      resources :viewing_parties, only: [:new]
    end
    resources :discover, only: [:index]
  end
end
