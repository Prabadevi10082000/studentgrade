# config/routes.rb

Rails.application.routes.draw do
    resources :grades, only: [:index, :create]
    root 'grades#index'
  end
  