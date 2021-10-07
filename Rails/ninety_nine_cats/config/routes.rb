Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests, only: [:create, :new] do
    patch 'approve', on: :member
    patch 'deny', on: :member
  end

  root to: redirect('/cats')
end
