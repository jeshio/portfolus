angular.module('portfolus').controller 'OrderProjectCtrl', [
  '$scope'
  'OrderProject'
  '$mdDialog'
  '$mdMedia'
  '$mdToast'
  'User'
  ($scope, OrderProject, $mdDialog, $mdMedia, $mdToast, User) ->
    # список
    # запрос списка

    loadOrderProjects = ->
      User.get($scope.authUser.id).then (result) ->
        result.orderProjects().then (projects) ->
          $scope.orderProjects = projects

    $scope.orderProjects = []
    loadOrderProjects()
    # удаление

    $scope.delete = (orderProject, ev) ->
      confirm = $mdDialog.confirm().title('Удалить?').ariaLabel('Процесс удаления записи.').targetEvent(ev).ok('Да').cancel('Нет')
      $mdDialog.show(confirm).then ->
        new OrderProject(orderProject).delete().then (result) ->
          $mdToast.show $mdToast.simple().textContent('Удалено.')
          loadOrderProjects()
]
