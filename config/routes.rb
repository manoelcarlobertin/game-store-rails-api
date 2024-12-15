Rails.application.routes.draw do
  post "users/auth" => "authentication#login", as: :login
  post "/users/sign_up" => "authentication#sign_up", as: :sign_up

  # config/routes.rbRails.application.routes.draw do
  resources :users, param: :_username
  post "/auth/login", to: "authentication#login"
  get "/*a", to: "application#not_found"


  namespace :admin do
    namespace :v1 do
      get "home" => "home#index"
    end
  end

  namespace :storefront do
    namespace :v1 do
    end
  end
end
