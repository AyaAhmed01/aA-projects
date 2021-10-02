Rails.application.routes.draw do
  # The eight routes could be made by next line
  resources :users
  # get 'users/:id', to: 'users#show', as: 'user' 
  # get 'users', to: 'users#index', as: 'users' 
  # post 'users', to: 'users#create' 
  # patch 'users/:id', to: 'users#update'
  # put 'users/:id', to: 'users#update'
  # delete 'users/:id', to: 'users#destroy'
  # get 'users/new', to: 'users#new', as: 'new_user'
  # get 'users/:id/edit', to: 'users#edit', as: 'edit_user' 
end
