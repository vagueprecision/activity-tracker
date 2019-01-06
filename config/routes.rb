Rails.application.routes.draw do
  root :to => 'dashboard#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :friends
  resources :goals
  resources :categories
  resources :auths
  resources :activities
  resources :users
end
