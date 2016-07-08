angular.module('rails').factory 'Organization', [
  'railsResourceFactory'
  (railsResourceFactory) ->
    resource = railsResourceFactory(
      url: '/api/organizations'
      name: 'organization')

    resource.whereYouAdmin = ->
      resource.$get(resource.$url('where_you_admin')).then (result) ->
        result

    resource.available = ->
      resource.$get(resource.$url('available')).then (result) ->
        result

    resource
]
