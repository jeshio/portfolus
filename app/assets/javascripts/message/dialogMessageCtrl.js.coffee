angular.module('portfolus').controller 'DialogMessageCtrl', [
  '$scope'
  'Message'
  '$mdDialog'
  '$mdMedia'
  '$mdToast'
  '$stateParams'
  'User'
  ($scope, Message, $mdDialog, $mdMedia, $mdToast, $stateParams, User) ->
    # список
    # запрос списка

    loadMessages = ->
      Message.dialog($scope.authUser.id, $stateParams.second).then (result) ->
        $scope.messages = result


    $scope.messages = []
    $scope.message =
      fromId: $scope.authUser.id
      toId: $stateParams.second
    $scope.second = {}
    loadMessages()

    $scope.sendMessage = ->
      message = new Message($scope.message)
      message.create().then ((result) ->
        $scope.message =
          fromId: $scope.authUser.id
          toId: $stateParams.second
        loadMessages()
      ), (errors) ->
        `var errors`
        errors = errors.data
        angular.forEach errors, (error, field) ->
          $scope.Message.$setValidity field, false, $scope.email
          serverMessage = $parse('Message.' + field + '.$error.serverMessage')
          serverMessage.assign $scope, error.join(', ')

    # запрос собеседника
    User.get($stateParams.second).then (data) ->
      $scope.second = data
]
