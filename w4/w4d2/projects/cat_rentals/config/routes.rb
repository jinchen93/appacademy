Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :cats
  resources :cat_rental_requests, only: [:new, :create]
  get 'cat_rental_requests/:id/deny', to: 'cat_rental_requests#deny', as: :deny_request
  get 'cat_rental_requests/:id/approve', to: 'cat_rental_requests#approve', as: :approve_request
end
