angular.module('portfolus')
.controller('MainCtrl',
function($scope, $mdSidenav, $mdUtil){
  $scope.test = 'Hello world!';
  $scope.openLeftMenu = buildToggler('left');

  function buildToggler(navID) {
    var debounceFn = $mdUtil.debounce(function () {
        $mdSidenav(navID)
            .toggle()
    }, 100);
    return debounceFn;
  }
});
