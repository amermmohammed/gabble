Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root 'pages#timeline'

  resources :users, only: [:index, :show] do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]
  get 'pages/timeline'
  get 'gabblers', to: 'users#index'

  resources :tweets, only: [:create, :edit, :update, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
