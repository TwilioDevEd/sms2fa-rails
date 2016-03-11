Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create]
  resources :secrets, only: [:index]
  resources :confirmations, only: [:new, :create]
  resources :secrets, only: [:index]

  get '/logout', to: 'sessions#destroy'

  root 'home#index'
end
