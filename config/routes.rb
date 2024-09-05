Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "up" => "rails/health#show", as: :rails_health_check
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  resources :items do
    resources :carts, only: %i[index new create destroy]
  end
    resources :carts do
      member do
        patch :accept
        patch :decline
      end
      collection do
        get :dashboard
        delete :remove_all
        resources :items
      end
    end
end
