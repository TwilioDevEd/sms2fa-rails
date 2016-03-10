Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resources :secrets, only: [:index]
  resources :confirmation, only: [:new, :create]

  get  'secret_contents', to: 'secret_contents#show'
  get  '/logout', to: 'sessions#destroy'
  post '/login', to: 'sessions#create'
  post '/verify-code', to: 'users#confirm'
  get  '/signin', to: 'sessions#new'
end
