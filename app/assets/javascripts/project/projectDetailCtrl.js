angular.module('portfolus')
.controller('ProjectDetailCtrl',['$scope', 'Project', '$stateParams',
function($scope, Project, $stateParams){
  $scope.project = {};

  Project.get($stateParams.id).then(function (result) {
    console.log(result);
    $scope.project = result;
  });
}]);
