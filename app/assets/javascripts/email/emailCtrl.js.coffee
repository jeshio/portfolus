angular.module('portfolus').controller 'EmailCtrl', [
  '$scope'
  'Email'
  '$parse'
  '$mdDialog'
  '$mdMedia'
  '$mdToast'
  'User'
  ($scope, Email, $parse, $mdDialog, $mdMedia, $mdToast, User) ->

    loadEmails = ->
      User.get($scope.authUser.id).then (result) ->
        result.emails().then (emails) ->
          $scope.emails = emails

    $scope.emails = []
    $scope.email = {}
    loadEmails()

    $scope.addEmail = ->
      new Email(email: email: $scope.email.email).create().then ((data) ->
        $mdToast.show $mdToast.simple().textContent('Email добавлен!')
        loadEmails()
        $scope.email = {}
      ), (errors) ->
        `var errors`
        errors = errors.data
        angular.forEach errors, (error, field) ->
          $scope.Email.$setValidity field, false, $scope.email
          serverMessage = $parse('Email.' + field + '.$error.serverMessage')
          serverMessage.assign $scope, error.join(', ')

    $scope.delete = (email, ev) ->
      # Appending dialog to document.body to cover sidenav in docs app
      confirm = $mdDialog.confirm().title('Удалить почту из списка?').ariaLabel('Удаление почты').targetEvent(ev).ok('Да').cancel('Нет')
      $mdDialog.show(confirm).then ->
        email.delete().then (result) ->
          loadEmails()
          $mdToast.show $mdToast.simple().textContent('Email удалён из сервиса!')
]
