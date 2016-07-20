Rails.application.routes.draw do

  root "static_pages#home"
  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :subjects
    resources :questions
  end
  devise_for :users, controllers: {registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"}
  resources :users, only: [:show, :edit, :update]
  resources :examinations, except: [:destroy, :update]

end
