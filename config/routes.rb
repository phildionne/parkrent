ParkRent::Application.routes.draw do

  devise_for :users

  resources :users

  resource :onboarding, only: [:new, :create]

  resources :parkings do
    resources :rents, except: [:index, :show]
  end

  resources :orders do
    resource :payment, except: :index
  end

  root :to => 'frontpage#show'
end
