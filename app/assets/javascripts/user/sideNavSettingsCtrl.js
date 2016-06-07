angular.module('portfolus')
.controller('SideNavSettingsCtrl',['$scope', 'User', '$state',
function($scope, User, $state){
  $scope.go = function (link) {
    $state.go(link);
  }
}]);
