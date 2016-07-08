angular.module('portfolus')
.controller('ProjectExecuterCtrl',['$scope', 'ProjectExecuter', '$stateParams', '$state',
function($scope, ProjectExecuter, $stateParams, $state){
  $scope.projectExecuter = {};
  $scope.project = {};

  ProjectExecuter.get($stateParams.projectExecuterId).then(function (result) {
    $scope.projectExecuter = result;
    $scope.project = result.project;
  });

  $scope.updateProjectExecuter = function () {
    $scope.projectExecuter.executer_confirmed = true;
    new ProjectExecuter($scope.projectExecuter).update().then(function () {
      $state.go('projectDetail', { executerId: $scope.project.createrId, projectId: $scope.project.id});
    });
  }

}]);
