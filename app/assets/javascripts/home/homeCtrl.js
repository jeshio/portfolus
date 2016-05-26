angular.module('portfolus')
.controller('HomeCtrl',['$scope', '$http',
function($scope, $http) {
  $scope.commits = [];
  $http({
    url: "/api/get_commits",
  })
  .success(function(data) {
      $scope.commits = data;
  })
  .error(function(status) {
    console.log(status);
  });
}]);
