angular.module('portfolus').controller 'DetailOrderExecuterRequestCtrl', [
  '$scope'
  'OrderExecuterRequest'
  '$parse'
  '$state'
  '$stateParams'
  '$mdDialog'
  '$mdMedia'
  '$mdToast'
  ($scope, OrderExecuterRequest, $parse, $state, $stateParams, $mdDialog, $mdMedia, $mdToast) ->
    # объект для формы
    $scope.orderExecuterRequest = {}
    # создать объект

    $scope.updateOrderExecuterRequest = ->
      orderExecuterRequest = new OrderExecuterRequest($scope.orderExecuterRequest)
      orderExecuterRequest.update().then ((result) ->
        $state.go 'orderExecuterRequests'
      ), (errors) ->
        `var errors`
        errors = errors.data
        angular.forEach errors, (error, field) ->
          $scope.OrderExecuterRequest.$setValidity field, false, $scope.email
          serverMessage = $parse('OrderExecuterRequest.' + field + '.$error.serverMessage')
          serverMessage.assign $scope, error.join(', ')

    # удаление

    $scope.delete = (ev) ->
      confirm = $mdDialog.confirm().title('Удалить?').ariaLabel('Удаление записи.').targetEvent(ev).ok('Да').cancel('Нет')
      $mdDialog.show(confirm).then ->
        $scope.orderExecuterRequest.delete().then (result) ->
          $mdToast.show $mdToast.simple().textContent('Удалено.')
          $state.go 'orderExecuterRequests'

    OrderExecuterRequest.get($stateParams.orderExecuterRequestId).then (result) ->
      $scope.orderExecuterRequest = result
]
