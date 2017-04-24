Rails.application.routes.draw do
  root 'subs#index'
  resources :posts
  resources :subs, path: 'r', param: :title
  resources :users, only: [:new, :create]
  resource :session, only: [:create, :new, :destroy]
end
