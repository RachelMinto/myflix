Myflix::Application.routes.draw do
  root to: "pages#front"

  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#index'

  resources :videos, only: [:show, :index] do
    collection do
      get 'search', to: 'videos#search'
    end
  end

  resources :categories, only: [:show, :index]
  resources :users, only: [:create]
  get '/register', to: 'users#new', as: :register
  get '/login', to: 'sessions#new', as: :login
end
