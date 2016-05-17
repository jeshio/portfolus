angular.module('portfolus')
.controller('MainCtrl',
function($scope, $mdSidenav, $mdUtil, $location) {
  $scope.test = 'Hello world!';
  $scope.openLeftMenu = buildToggler('left');

  function buildToggler(navID) {
    var debounceFn = $mdUtil.debounce(function () {
        $mdSidenav(navID)
            .toggle()
    }, 100);
    return debounceFn;
  }

  $scope.getClass = function (path) {
    return ($location.path().substr(0, path.length) === path) ? 'active' : '';
  }
});
