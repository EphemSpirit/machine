Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/destroy'
  get '/index', to: 'users#index'
  get '/users' => 'users#index', :as => :user_root
  devise_for :users
  root 'users#home'
  resources :users do
    resources :friendships, only: [:index, :new, :create, :destroy]
    resources :requests
  end
  resource :profile
end
