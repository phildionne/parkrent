ParkRent::Application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  resources :users

  resource :onboarding, only: [:new, :create]

  resources :guest_orders, only: [:new, :create]

  resources :vehicles, except: [:index, :show]

  resources :parkings do
    resources :rents, except: [:index, :show]
  end

  resources :orders, except: [:index] do
    resource :payment, except: :index
  end

  root :to => 'frontpage#show'
end
