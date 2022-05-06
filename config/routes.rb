Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks
  resources :users, only:[:new, :create, :show, :edit, :update]
  root to: 'tasks#index'
end
