Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/destroy'
  get '/index', to: 'users#index'
  get '/users' => 'users#index', :as => :user_root
  devise_for :users

  devise_scope :user do
    root 'devise/registrations#new'
  end

  resources :users do
    resources :friendships, only: [:index, :new, :create, :destroy]
    resources :requests
    resource :profile
  end

  resources :posts, only: [:new, :show, :create, :destroy] do
    resources :likings, only: [:new, :create, :destroy]
    resources :comments, only: [:new, :create]
  end

end
