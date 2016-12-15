Rails.application.routes.draw do
  root 'home#index'

  get '/sessions/new', to: 'sessions#new'
  get '/oauth/authorize', to: 'sessions#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
