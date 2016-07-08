angular.module('portfolus').controller 'OrderExecuterRequestCtrl', [
  '$scope'
  'OrderExecuterRequest'
  '$mdDialog'
  '$mdMedia'
  '$mdToast'
  'User'
  ($scope, OrderExecuterRequest, $mdDialog, $mdMedia, $mdToast, User) ->
    # список
    # запрос списка

    loadOrderExecuterRequests = ->
      User.get($scope.authUser.id).then (result) ->
        result.orderExecuterRequests().then (result) ->
          $scope.orderExecuterRequests = result

    $scope.orderExecuterRequests = []
    loadOrderExecuterRequests()
    # удаление

    $scope.delete = (orderExecuterRequest, ev) ->
      confirm = $mdDialog.confirm().title('Удалить?').ariaLabel('Процесс удаления записи.').targetEvent(ev).ok('Да').cancel('Нет')
      $mdDialog.show(confirm).then ->
        new OrderExecuterRequest(orderExecuterRequest).delete().then (result) ->
          $mdToast.show $mdToast.simple().textContent('Удалено.')
          loadOrderExecuterRequests()
]
