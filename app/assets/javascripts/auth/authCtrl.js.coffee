angular.module('portfolus').controller 'AuthCtrl', [
  '$scope'
  '$state'
  '$parse'
  'Auth'
  'City'
  ($scope, $state, $parse, Auth, City) ->
    # пошаговая регистрация
    $scope.max = 2
    $scope.selectedIndex = 0

    $scope.nextTab = ->
      index = if $scope.selectedIndex is $scope.max then 0 else $scope.selectedIndex + 1
      $scope.selectedIndex = index

    $scope.user = {}
    $scope.cities = []
    City.query().then (result) -> $scope.cities = result

    $scope.login = ->
      Auth.login($scope.user).then ((user) ->
        $state.go 'user', id: user.id
      ), (data) ->
        $scope.errors = authError: 'authError'

    $scope.register = ->
      Auth.register($scope.user).then ((user) ->
        $state.go 'user', id: user.id
      ), (data) ->
        # обработка ошибок с серверной стороны
        errors = data.data.errors
        angular.forEach errors, (error, field) ->
          $scope.User.$setValidity field, false, $scope.user
          serverMessage = $parse('User.' + field + '.$error.serverMessage')
          serverMessage.assign $scope, error.join(', ')
        $scope.selectedIndex = 0
]
