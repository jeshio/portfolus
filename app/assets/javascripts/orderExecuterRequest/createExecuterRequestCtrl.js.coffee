angular.module('portfolus').controller 'CreateOrderExecuterRequestCtrl', [
  '$scope'
  'OrderExecuterRequest'
  '$parse'
  '$state'
  ($scope, OrderExecuterRequest, $parse, $state) ->
    # объект для формы
    $scope.orderExecuterRequest = byCustomer: false
    # создать объект

    $scope.createOrderExecuterRequest = ->
      orderExecuterRequest = new OrderExecuterRequest($scope.orderExecuterRequest)
      orderExecuterRequest.create().then ((result) ->
        $state.go 'orderExecuterRequests'
      ), (errors) ->
        `var errors`
        errors = errors.data
        angular.forEach errors, (error, field) ->
          $scope.OrderExecuterRequest.$setValidity field, false, $scope.email
          serverMessage = $parse('OrderExecuterRequest.' + field + '.$error.serverMessage')
          serverMessage.assign $scope, error.join(', ')
]
