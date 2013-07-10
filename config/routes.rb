ParkRent::Application.routes.draw do
  resources :parkings

  resources :rents
  root :to => 'frontpage#show'
end
