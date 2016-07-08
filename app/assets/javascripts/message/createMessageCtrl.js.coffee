angular.module('portfolus').controller 'CreateMessageCtrl', [
  '$scope'
  'Message'
  '$parse'
  '$state'
  ($scope, Message, $parse, $state) ->
    # объект для формы
    $scope.message = {}
    # создать объект

    $scope.createMessage = ->
      message = new Message($scope.message)
      message.create().then ((result) ->
        $state.go 'messages'
      ), (errors) ->
        `var errors`
        errors = errors.data
        angular.forEach errors, (error, field) ->
          $scope.Message.$setValidity field, false, $scope.email
          serverMessage = $parse('Message.' + field + '.$error.serverMessage')
          serverMessage.assign $scope, error.join(', ')
]
