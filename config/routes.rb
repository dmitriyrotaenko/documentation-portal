Rails.application.routes.draw do
  namespace :admin do
      resources :roles
      resources :projects
      resources :pages
      resources :users

      root to: "roles#index"
    end
  devise_for :users
  root "projects#index"

  resources :projects do
      resources :pages
  end
end
