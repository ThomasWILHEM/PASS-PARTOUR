Rails.application.routes.draw do
  resources :reservations, only: [:index, :show, :new, :create, :edit, :destroy]
  resources :flights

  devise_for :users

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  root to: 'flights#index'
end