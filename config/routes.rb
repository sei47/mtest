Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks
  namespace :admin do
    resources :users, only:[:new, :create, :show, :edit, :update]
  end
  root to: 'tasks#index'
end
