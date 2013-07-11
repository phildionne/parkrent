ParkRent::Application.routes.draw do
  resources :payments

  resources :parkings do
    resources :rents
  end

  resources :orders

  root :to => 'frontpage#show'
end
