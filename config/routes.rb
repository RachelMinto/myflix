Myflix::Application.routes.draw do
  root to: "pages#front"

  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#index'

  resources :videos, only: [:show, :index] do
    collection do
      get 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

  resources :categories, only: [:show, :index]
  resources :users, only: [:create]
  resources :sessions, only: [:create]
  resources :user_videos, only: [:index, :create]  

  get '/register', to: 'users#new', as: :register
  get '/login', to: 'sessions#new', as: :login
  get '/logout', to: 'sessions#destroy', as: :logout  
end
