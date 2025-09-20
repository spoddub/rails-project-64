Rails.application.routes.draw do
  root "pages#home"
  devise_for :users

  # Healthcheck
  get "up" => "rails/health#show", as: :rails_health_check
  namespace :account do
    resources :posts, only: %i[index new create]
  end
end
