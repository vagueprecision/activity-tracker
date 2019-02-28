Rails.application.routes.draw do
  root to: 'landing#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :dashboard, only: [:index]
  resources :user_goals, only: [:new, :edit, :create, :update, :destroy]
  resources :user_activities, only: [:new, :edit, :create, :update, :destroy, :index]
  resources :categories, only: [:index]
  resources :activities, only: [:index]
end
