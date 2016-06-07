angular.module('portfolus')
.controller('MainCtrl',['$scope', '$mdSidenav', '$mdUtil', '$location', 'Auth', '$state', '$rootScope',
function($scope, $mdSidenav, $mdUtil, $location, Auth, $state, $rootScope) {
  $scope.test = 'Hello world!';
  $scope.openLeftMenu = buildToggler('left');

  function buildToggler(navID) {
    var debounceFn = $mdUtil.debounce(function () {
        $mdSidenav(navID)
            .toggle()
    }, 100);
    return debounceFn;
  }

  
}]);
