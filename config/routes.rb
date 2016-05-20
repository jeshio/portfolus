Rails.application.routes.draw do
  devise_for :users
  
  scope '/api' do
    resources :cities
    resources :countries
    resources :project_confirms
    resources :project_executers
    resources :project_tags
    resources :project_technologies
    resources :projects
    resources :user_organizations
    resources :organizations
    resources :tags
    resources :technologies
    resources :categories
  end

  match "api", to: proc { [404, {}, ['Invalid API endpoint']] }, via: :all
  match "api/*path", to: proc { [404, {}, ['Invalid API endpoint']] }, via: :all

  match "/*path", to: "application#angular", via: :all

  root 'application#angular'
end
