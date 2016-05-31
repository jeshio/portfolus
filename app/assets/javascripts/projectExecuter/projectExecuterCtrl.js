angular.module('portfolus')
.controller('ProjectExecuterCtrl',['$scope', 'ProjectExecuter',
function($scope, ProjectExecuter){
  $scope.projectExecuters = [];
  ProjectExecuter.query().then(function (result) {
    $scope.projectExecuters = result;
  });
}]);
