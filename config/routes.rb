Rails.application.routes.draw do
  root "pages#home"
  devise_for :users

  resources :posts, only: [ :show, :new, :create ] do
    resource :like, only: [ :create, :destroy ], controller: "likes"

    resources :comments, only: [ :create ], controller: "comments"
  end

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :account do
    resources :posts, only: %i[index new create]
  end
end
