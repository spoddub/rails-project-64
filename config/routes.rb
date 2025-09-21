# frozen_string_literal: true

Rails.application.routes.draw do
  # Healthcheck
  get '/up', to: 'rails/health#show', as: :rails_health_check

  # Devise
  devise_for :users

  root 'pages#home'

  resources :posts, only: %i[new create show] do
    resources :comments, only: %i[create], controller: 'comments'

    resource :like, only: %i[create destroy], controller: 'likes'

    post   'likes', to: 'likes#create', as: :likes
    delete 'likes', to: 'likes#destroy'
  end

  namespace :account do
    resources :posts, only: %i[index new create]
  end
end
