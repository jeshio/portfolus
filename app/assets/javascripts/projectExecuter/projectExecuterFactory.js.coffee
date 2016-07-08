angular.module('rails').factory 'ProjectExecuter', [
  'railsResourceFactory'
  (railsResourceFactory) ->
    resource = railsResourceFactory(
      url: '/api/project_executers'
      name: 'projectExecuter')

    resource.getWithConfirms = (params) ->
      # формируем GET запрос
      query = []
      angular.forEach params, (el, key) ->
        query['project_executer[' + key + ']'] = el
      resource.$get(resource.$url('get_with_confirms'), query).then (result) ->
        result

    resource
]
