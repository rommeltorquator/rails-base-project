Rails.application.routes.draw do
  devise_for :admins
  devise_for :buyers
  devise_for :brokers

  resources :stocks, only: [ :index, :show, :create, :destroy ] do
    collection do
      get 'watch', to: "stocks#watch"
      get 'unwatch', to: "stocks#unwatch"
      patch 'cash_in', to: "stocks#cash_in"
      post 'add_stock'
      delete 'sell_buyer_stock/:id', to: "stocks#destroy_buyer_stock", as: "sell_buyer_stock"      
    end
  end

  resources :home, only: [ :index ] do
    collection do # would not ask for a param
      get 'portfolio'
      get 'transaction'
      get 'show_user/:id', to: "home#show_user", as: "show_user"
      patch 'update_approved_status/', to: "home#approve"

      patch 'update_buyer', to: "home#update_buyer", as: "update_buyer"
      post 'create_user', to: "home#create_user", as: "create_user"
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"
end
