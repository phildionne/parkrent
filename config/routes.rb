ParkRent::Application.routes.draw do
  resources :parkings do
    resources :rents
  end

  resources :orders do
    resources :line_items
  end

  root :to => 'frontpage#show'
end
