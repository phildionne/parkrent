ParkRent::Application.routes.draw do

  devise_for :users

  resources :users

  resource :onboarding, only: [:new, :create]

  resource :guest_order, only: [:new, :create]

  resources :vehicles, except: [:index, :show]

  resources :parkings do
    resources :rents, except: [:index, :show]
  end

  resources :orders do
    resource :payment, except: :index
  end

  root :to => 'frontpage#show'
end
