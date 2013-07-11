ParkRent::Application.routes.draw do
  resources :line_items

  resources :parkings
  resources :orders
  resources :rents

  root :to => 'frontpage#show'
end
