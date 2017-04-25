Rails.application.routes.draw do
  root 'subs#index'
  resources :subs, path: 'r', param: :title

  resources :posts do
    resources :comments, only: [:new]
  end
  resources :comments, only: [:create, :show]

  resources :users, only: [:new, :create]
  resource :session, only: [:create, :new, :destroy]
end
