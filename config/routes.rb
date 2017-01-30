Rails.application.routes.draw do
  namespace :admin do
    resources :orders
    resources :users
    resources :backgrounds
    root to: "orders#index"
  end

  devise_for :users
  root to: "welcome#index"
end
