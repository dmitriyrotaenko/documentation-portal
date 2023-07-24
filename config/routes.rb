Rails.application.routes.draw do
  devise_for :users
  root "projects#index"

  resources :projects do
      resources :pages do
        collection do
          # post method is required for working with turbo streams
          post :search
        end
      end
  end
end
