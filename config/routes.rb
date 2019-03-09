Rails.application.routes.draw do
  root to: 'landing#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :dashboard, only: [:index]
  resources :goals, controller: 'user_goals', only: [:new, :edit, :create, :update, :destroy] do
    resources :activities, controller: 'goal_activities', only: [:index]
  end
  resources :activities, controller: 'user_activities', only: [:new, :edit, :create, :update, :destroy, :index]
  resources :categories, only: [:index]
  resources :activity_definitions, controller: 'activities', only: [:index]
end
