Rails.application.routes.draw do
  root "projects#index"

  namespace :admin do
      resources :roles
      resources :projects
      resources :pages
      resources :users

      root to: "roles#index"
    end
  devise_for :users

  resources :projects do
      resources :pages
  end
end
