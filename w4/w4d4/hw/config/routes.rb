Rails.application.routes.draw do

  resource :sessions, only: [:new, :create, :destroy]

  resources :users, only: [:new, :create, :show]

  resources :bands do
    resources :albums, only: [:new]
  end

  resources :albums, except: [:new, :index] do
    resources :tracks, only: [:new]
  end

  resources :tracks, except: [:new, :index]


  resources :notes, only: [:create, :destroy]

end
