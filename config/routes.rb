Rails.application.routes.draw do
  root "static_pages#home"
  namespace :admin do
    resources :users, except: [:create, :new, :show]
    resources :subjects
  end
  devise_for :users, controllers: {registrations: "users/registrations"}
  resources :users, only: [:show, :edit, :update]

end
