Rails.application.routes.draw do
  resources :reservations, only: [:index, :show, :new, :create, :edit]
  resources :flights

  devise_for :users
  root to: 'flights#index'
end