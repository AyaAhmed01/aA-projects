Rails.application.routes.draw do
  # The total eight routes:
  # get 'users/:id', to: 'users#show', as: 'user' 
  # get 'users', to: 'users#index', as: 'users' 
  # post 'users', to: 'users#create' 
  # patch 'users/:id', to: 'users#update'
  # put 'users/:id', to: 'users#update'
  # delete 'users/:id', to: 'users#destroy'
  # get 'users/new', to: 'users#new', as: 'new_user'
  # get 'users/:id/edit', to: 'users#edit', as: 'edit_user' 

  resources :users, only: [:index, :show, :create, :update, :destroy] do 
    resources :artworks, only: [:index]
  end
  resources :artworks, only: [:show, :create, :update, :destroy]
  resources :artwork_shares, only: [:create, :destroy]
  resources :comments, only: [:create, :index, :destroy]
end
