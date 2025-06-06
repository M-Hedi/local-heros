Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "events/:id", to: "events#show"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :searches

  resources :orders do
    member do
    patch :accepted
    patch :refused
    end
  end

  resources :stores
  resources :events
  resources :stores do
    resources :products, only: [:new, :create, :show, :edit, :update]
  end
end
