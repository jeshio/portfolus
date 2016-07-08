angular.module('rails').factory 'User', [
  'railsResourceFactory'
  '$http'
  (railsResourceFactory, $http) ->
    resource = railsResourceFactory(
      url: '/api/users'
      name: 'user')

    resource.getAllProjects = (user_id) ->
      resource.$get resource.$url(user_id + '/all_projects')

    resource::userOrganizations = ->
      resource.$get resource.$url(@id + '/user_organizations')

    resource::emails = ->
      resource.$get resource.$url(@id + '/emails')

    resource::executerRequests = ->
      resource.$get resource.$url(@id + '/executer_requests')

    resource::orderProjects = ->
      resource.$get resource.$url(@id + '/order_projects')

    resource::toExecuterRequests = ->
      resource.$get resource.$url(@id + '/to_executer_requests')

    resource::orderExecuterRequests = ->
      resource.$get resource.$url(@id + '/order_executer_requests')

    resource::organizations = ->
      resource.$get resource.$url(@id + '/organizations')

    resource
]
