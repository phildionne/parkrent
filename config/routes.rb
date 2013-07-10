ParkRent::Application.routes.draw do
  resources :parkings
  resources :transactions

  resources :rents
  root :to => 'frontpage#show'
end
