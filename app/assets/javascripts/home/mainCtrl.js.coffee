angular.module('portfolus').controller 'MainCtrl', [
  '$scope'
  '$mdSidenav'
  '$mdUtil'
  '$location'
  'Auth'
  '$state'
  '$rootScope'
  ($scope, $mdSidenav, $mdUtil, $location, Auth, $state, $rootScope) ->

    buildToggler = (navID) ->
      $mdUtil.debounce((-> $mdSidenav(navID).toggle()), 100)

    $scope.toggleLeftMenu = buildToggler('left');
]
