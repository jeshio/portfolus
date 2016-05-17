Rails.application.routes.draw do
  resources :cities
  resources :countries
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#angular'
end
