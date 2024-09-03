Rails.application.routes.draw do
  get 'carts/index'
  get 'carts/create'
  get 'carts/new'
  get 'carts/destroy'
  get 'items/index'
  get 'items/show'
  get 'items/create'
  get 'items/destroy'
  devise_for :users
  root to: 'pages#home'
  get "up" => "rails/health#show", as: :rails_health_check

  resources :carts, only: [:index, :create] do
    member do
      patch :accept
      patch :decline
    end
  end

  resources :items do
    resources :carts, only: %i[new create destroy]
  end
end
