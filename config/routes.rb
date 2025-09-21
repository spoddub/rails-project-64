Rails.application.routes.draw do
  root "pages#home"
  devise_for :users
  resources :posts, only: [ :show ] do
    resource :post_like, only: [ :create, :destroy ],
                         controller: "likes",
                         as: :like,
                         path: "like"
    resources :comments, only: [ :create ], controller: "comments"
  end
  # Healthcheck
  get "up" => "rails/health#show", as: :rails_health_check
  namespace :account do
    resources :posts, only: %i[index new create]
  end
end
