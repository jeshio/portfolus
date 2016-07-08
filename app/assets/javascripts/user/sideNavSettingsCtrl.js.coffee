angular.module('portfolus').controller 'SideNavSettingsCtrl', [
  '$scope'
  'User'
  '$state'
  ($scope, User, $state) ->

    $scope.go = (link) ->
      $scope.toggleLeftMenu()
      $state.go link
]
