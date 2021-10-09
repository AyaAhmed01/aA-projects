Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests, only: [:create, :new] do
    patch 'approve', on: :member
    patch 'deny', on: :member
  end
  resources :users, only:[:new, :create]
  resource :session, only:[:new, :create, :destroy]
  root to: redirect('/cats')
end

