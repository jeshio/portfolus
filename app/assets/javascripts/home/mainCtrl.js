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

  $scope.$on('devise:new-registration', function (e, user){
    $rootScope.authUser = user;
    $rootScope.signedIn = true;
  });

  $scope.$on('devise:login', function (e, user){
    $rootScope.authUser = user;
    $rootScope.signedIn = true;
  });

  $scope.$on('devise:logout', function (e, user){
    $rootScope.authUser = {};
    $rootScope.signedIn = false;
    $state.go('home');
  });
}]);
