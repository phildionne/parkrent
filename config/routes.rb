ParkRent::Application.routes.draw do

  resources :users

  resources :parkings do
    resources :rents, except: [:index, :show]
  end

  resources :orders do
    resource :payment, except: :index
  end

  root :to => 'frontpage#show'
end
