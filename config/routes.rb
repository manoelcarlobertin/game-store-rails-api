Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth/v1/user'
  # scope :authentication do
  #   post "/login", to: "authentication#login", as: :login
  #   post "/sign_up", to: "authentication#sign_up", as: :sign_up
  # end

  # resources :users, param: :_username

  # get "/*a", to: "application#not_found"

  namespace :admin do
    namespace :v1 do
      get "home", to: "home#index"
      resources :categories
      resources :products
    end
  end

  namespace :storefront do
    namespace :v1 do
      get "home", to: "home#index"
      resources :categories, only: [:index, :show, :create, :update, :destroy]
      resources :products, only: [:index, :show]
    end
  end
end
