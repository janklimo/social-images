Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :backgrounds
    root to: "users#index"
  end

  devise_for :users
  root to: "welcome#index"
end
