Rails.application.routes.draw do
  root to: 'landing#index'

  namespace :settings do
    resources :setup, only: [:index, :create]
    resources :proxies do
      get :test, on: :member
    end
  end
end
