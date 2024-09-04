Rails.application.routes.draw do
  # get 'carts/index'
  # get 'carts/create'
  # get 'carts/new'
  # get 'carts/destroy'
  # get 'items/index'
  # get 'items/create'
  # get 'items/show'
  # get 'items/destroy'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "up" => "rails/health#show", as: :rails_health_check
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  resources :items do
    resources :carts, only: %i[new create destroy]
  end
  # Defines the root path route ("/")
  # root "posts#index"
end
