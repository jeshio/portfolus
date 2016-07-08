angular.module('portfolus').controller 'MessageCtrl', [
  '$scope'
  'Message'
  '$mdDialog'
  '$mdMedia'
  '$mdToast'
  '$stateParams'
  '$state'
  ($scope, Message, $mdDialog, $mdMedia, $mdToast, $stateParams, $state) ->
    # список
    # запрос списка

    loadDialogs = ->
      Message.dialogs().then (dialogs) ->
        $scope.dialogs = dialogs

    $scope.dialogs = []
    loadDialogs()

    $scope.openDialog = (msg) ->
      if `msg.fromId == $scope.authUser.id`
        $state.go 'dialog', second: msg.toId
      else
        $state.go 'dialog', second: msg.fromId
]
