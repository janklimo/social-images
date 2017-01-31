Rails.application.routes.draw do
  namespace :admin do
    resources :orders
    resources :users
    resources :backgrounds
    root to: "orders#index"
  end

  devise_for :users

  resources :orders, param: :token, only: :show

  root to: "welcome#index"
end
