angular.module('rails').factory 'OrderExecuterRequest', [
  'railsResourceFactory'
  (railsResourceFactory) ->
    resource = railsResourceFactory(
      url: '/api/order_executer_requests'
      name: 'orderExecuterRequest')
    resource
]
