angular.module('rails').factory 'Search', [
  'railsResourceFactory'
  (railsResourceFactory) ->
    resource = railsResourceFactory(
      url: '/api/search'
      name: 'search')

    resource.executers = (params) ->
      resource.$get resource.$url('executers'), params

    resource.projects = (params) ->
      resource.$get resource.$url('projects'), params

    resource.orders = (params) ->
      resource.$get resource.$url('orders'), params

    resource
]
