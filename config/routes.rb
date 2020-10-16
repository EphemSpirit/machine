Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/destroy'
  get '/index', to: 'users#index'
  get '/users' => 'users#index', :as => :user_root 
  devise_for :users#, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'users#home'
  resources :users
end
