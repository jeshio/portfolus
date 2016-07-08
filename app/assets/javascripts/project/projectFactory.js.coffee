angular.module('rails').factory 'Project', [
  'railsResourceFactory'
  (railsResourceFactory) ->
    resource = railsResourceFactory(
      url: '/api/projects'
      name: 'project')

    resource.getDetail = (params) ->
      # формируем GET запрос
      query = []
      angular.forEach params, (el, key) ->
        query['project[' + key + ']'] = el
      resource.$get(resource.$url('get_detail'), query).then (result) ->
        result

    resource
]
