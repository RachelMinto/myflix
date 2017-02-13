Myflix::Application.routes.draw do
  root to: "pages#front"

  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#index'
  get '/my_queue', to: 'user_videos#index'
  get 'people', to: 'relationships#index'

  resources :videos, only: [:show, :index] do
    collection do
      get 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
    resources :user_videos, only: [:index, :create]      
  end

  resources :relationships, only: [:create, :destroy]
  resources :categories, only: [:show, :index]
  resources :users, only: [:create, :show]
  resources :sessions, only: [:create]
  resources :user_videos, only: [:destroy]
  post '/update_queue', to: 'user_videos#update_queue'

  get '/register', to: 'users#new', as: :register
  get '/login', to: 'sessions#new', as: :login
  get '/logout', to: 'sessions#destroy', as: :logout

  get '/forgot_password', to: 'forgot_passwords#new'
  get '/forgot_password_confirmation', to: 'forgot_passwords#confirm'
  resources :forgot_passwords, only: [:create]
  
  resources :password_resets, only: [:show, :create]
  get 'expired_token', to: 'password_resets#expired_token'
end
