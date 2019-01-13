Rails.application.routes.draw do
  root to: 'dashboard#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :user_goals, only: [:new, :edit, :create, :update, :destroy]
  resources :user_activities, only: [:new, :edit, :create, :update, :destroy]
  resources :categories, only: [:index]
  resources :activities, only: [:index]
end
