Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "registrations" }
  root "pages#timeline"


  resources :users, only: [:index, :show] do
    member do
      get :following
      get :followers
    end
  end

  resources :relationships, only: [:create, :destroy]
  get "pages/timeline"
  get 'gabblers', to: "users#index"
  post :notifications, to: "notifications#mark_all_read"
  resources :tweets, only: [:create, :edit, :update, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Define likes resources
  resources :likes, only: [:create, :destroy], param: :likeable_id

  # Define comments resources
  resources :comments, only: [:create, :destroy]

  # Define retweets resources
  resources :retweets, only: [:create, :destroy]

  # Defines the root path route ("/")
  # root "articles#index"
end
