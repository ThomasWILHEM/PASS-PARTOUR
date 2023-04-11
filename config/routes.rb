Rails.application.routes.draw do
  resources :reservations
  get 'flights/index'
  get 'flights/show'
  get 'flights/new'
  get 'flights/edit'
  resources :flights

  devise_for :users
  root 'application#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
