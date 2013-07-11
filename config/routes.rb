ParkRent::Application.routes.draw do
  resources :parkings
  resources :rents

  resources :orders do
    resources :line_items
  end

  root :to => 'frontpage#show'
end
