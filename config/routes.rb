# frozen_string_literal: true
require 'sidekiq/web'
Rails.application.routes.draw do
  root 'home#index'
  mount Sidekiq::Web => '/sidekiq'

  resources :instagram_accounts, only: :index do
    resources :media_objects,
              only: :index,
              controller: 'instagram_account/media_objects'
  end

  # A bit not restfull
  get '/sessions/new', to: 'sessions#new'
  get '/oauth/authorize', to: 'sessions#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
