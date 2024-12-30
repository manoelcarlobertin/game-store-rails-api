Rails.application.routes.draw do
  # scope :authentication do
  #   post "/login", to: "authentication#login", as: :login
  #   post "/sign_up", to: "authentication#sign_up", as: :sign_up
  # end

  # resources :users, param: :_username

  # get "/*a", to: "application#not_found"

  namespace :admin do
    namespace :v1 do
<<<<<<< HEAD
      get "home", to: "home#index"
      resources :categories
      resources :products
    end
  end

  namespace :storefront do
    namespace :v1 do
      get "home" => "home#index"
=======
      resources :categories, only: [ :index, :show, :create, :update, :destroy ]
    end
  end

  # namespace :admin do
  #   namespace :v1 do
  #     resources :categories, only: [ :create ]
  #   end
  # end

  namespace :admin do
    namespace :v1 do
        get "home", to: "home#index"
    end
  end

  namespace :storefront do
    namespace :v1 do
>>>>>>> 6ad46b8826e08838da68a791b6bfbe391807d51c
    end
  end
end
