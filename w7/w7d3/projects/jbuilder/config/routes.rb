Rails.application.routes.draw do
 # Your routes here!
 namespace :api, defaults: { format: :json } do
   resources :guests, only: [:index, :show]
   resources :parties, only: [:index, :show]
   resources :gifts, only: [:index, :show]
 end
end
