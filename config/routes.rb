Rails.application.routes.draw do
  resources :emails
  devise_for :users

  scope '/api' do
    resources :cities
    resources :countries

    resources :project_confirms
    post 'project_confirms/create_with_project_and_user', to: 'project_confirms#create_with_project_and_user'
    post 'project_confirms/search_with_project_and_user', to: 'project_confirms#search_with_project_and_user'

    get 'project_executers/get_with_confirms', to: 'project_executers#get_with_confirms'
    resources :project_executers

    resources :project_tags
    resources :project_technologies

    get 'projects/get_detail', to: 'projects#get_detail'
    resources :projects

    resources :user_organizations
    resources :organizations
    resources :tags

    get 'users/:id/all_projects', to: 'users#all_projects'
    resources :users


    resources :technologies
    resources :categories
    resources :emails

    get 'get_commits', to: 'application#get_commits'
    get 'search', to: 'search#query'
  end

  match "api", to: proc { [404, {}, ['Invalid API endpoint']] }, via: :all
  match "api/*path", to: proc { [404, {}, ['Invalid API endpoint']] }, via: :all

  match "/*path", to: "application#angular", via: :all

  root 'application#angular'
end
