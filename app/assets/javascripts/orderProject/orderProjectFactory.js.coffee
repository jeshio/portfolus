angular.module('rails').factory 'OrderProject', [
  'railsResourceFactory'
  (railsResourceFactory) ->
    resource = railsResourceFactory(
      url: '/api/order_projects'
      name: 'orderProject')
    resource
]
