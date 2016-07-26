Rails.application.routes.draw do

  root "static_pages#home"
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :subjects
    resources :questions
    resources :examinations, only: [:index, :update]
  end
  devise_for :users, controllers: {registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks", sessions: "users/sessions"}
  resources :users, only: [:show, :edit, :update]
  resources :questions, only: [:new, :index, :create]
  resources :examinations, except: :destroy

end
