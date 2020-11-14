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
    resource :profile
  end
  resources :posts, only: [:new, :create, :destroy] do
    resources :likings, only: [:new, :create, :destroy]    
  end

end
