Rails.application.routes.draw do
  root "pages#home"
  devise_for :users

  resources :posts, only: [ :show ] do
    resource  :like,     only: [ :create, :destroy ], controller: "likes"
    resources :comments, only: [ :create ],           controller: "comments"
  end


  post "/posts/:post_id/likes", to: "likes#create", as: :post_likes

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :account do
    resources :posts, only: [ :index, :new, :create ]
  end
end
