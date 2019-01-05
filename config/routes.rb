Rails.application.routes.draw do
  root :to => 'activities#index'

  resources :friends
  resources :goals
  resources :categories
  resources :auths
  resources :activities
  resources :users
end
