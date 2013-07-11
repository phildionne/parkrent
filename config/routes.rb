ParkRent::Application.routes.draw do

  resources :parkings do
    resources :rents
  end

  resources :orders do
    resource :payment, except: :index
  end

  root :to => 'frontpage#show'
end
