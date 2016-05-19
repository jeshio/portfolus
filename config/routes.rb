Rails.application.routes.draw do
  scope '/api' do
    resources :cities
    resources :countries
  end

  devise_for :users

  match "api", to: proc { [404, {}, ['Invalid API endpoint']] }, via: :all
  match "api/*path", to: proc { [404, {}, ['Invalid API endpoint']] }, via: :all

  match "/*path", to: "application#angular", via: :all

  root 'application#angular'
end
