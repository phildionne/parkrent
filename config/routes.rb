ParkRent::Application.routes.draw do
  resources :parkings
  resources :orders
  resources :rents

  root :to => 'frontpage#show'
end
