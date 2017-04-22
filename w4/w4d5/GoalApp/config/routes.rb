Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show] do
    resources :goals, except: [:index]
  end
  resource :session, only: [:new, :create, :destroy]
end
