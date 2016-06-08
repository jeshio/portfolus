angular.module('portfolus')
.controller('PortfolioCtrl',['$scope', 'User', '$stateParams',
function($scope, User, $stateParams){
  $scope.projects = [];
  $scope.userId = $stateParams.id;

  User.getAllProjects($stateParams.id).then(function (result) {
    $scope.projects = result;
  }, function (error) {
    console.log(error);
  });

}]);
