Rails.application.routes.draw do
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
    end
  end

  namespace :storefront do
    namespace :v1 do
    end
  end
end
