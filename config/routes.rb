Rails.application.routes.draw do
  devise_for :users

  scope '/api' do
    resources :cities
    resources :countries
    resources :emails

    resources :project_confirms
    post 'project_confirms/create_with_project_and_user', to: 'project_confirms#create_with_project_and_user'
    post 'project_confirms/search_with_project_and_user', to: 'project_confirms#search_with_project_and_user'

    get 'project_executers/get_with_confirms', to: 'project_executers#get_with_confirms'
    resources :project_executers

    get 'projects/get_detail', to: 'projects#get_detail'
    resources :projects

    get 'organizations/available', to: 'organizations#available'
    get 'organizations/where_you_admin', to: 'organizations#where_you_admin'
    resources :organizations

    # FIXME исключить ненужные роуты, которые используется только с зависимостью от пользователя
    resources :order_projects
    resources :order_executer_requests
    resources :user_organizations

    get 'users/:id/all_projects', to: 'users#all_projects'
    get 'users/:id/to_executer_requests', to: 'users#to_executer_requests'
    get 'users/:id/executer_requests', to: 'users#executer_requests'
    resources :users do
      resources :emails
      resources :order_projects
      resources :order_executer_requests
      resources :user_organizations
    end

    resources :categories

    get 'get_commits', to: 'application#get_commits'
    get 'search/executers', to: 'search#executers'
    get 'search/projects', to: 'search#projects'
    get 'search/orders', to: 'search#orders'
  end

  match "api", to: proc { [404, {}, ['Invalid API endpoint']] }, via: :all
  match "api/*path", to: proc { [404, {}, ['Invalid API endpoint']] }, via: :all

  match "/*path", to: "application#angular", via: :all

  root 'application#angular'
end
