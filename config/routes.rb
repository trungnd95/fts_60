Rails.application.routes.draw do
  root "static_pages#home"

  namespace :admin do
    resources :users, except: [:create, :new, :show]
  end
end
