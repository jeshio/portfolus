angular.module('portfolus')
.controller('CreateProjectExecuterCtrl',['$scope', 'ProjectExecuter', 'Project', '$stateParams', '$state', '$parse',
function($scope, ProjectExecuter, Project, $stateParams, $state, $parse){
  $scope.projectExecuter = {project_id: $stateParams.projectId};
  $scope.project = {};

  $scope.addProjectExecuter = function () {
    var projectExecuter = new ProjectExecuter($scope.projectExecuter);
    projectExecuter.create().then(function (result) {
      $state.go('projectDetail', { executerId: $scope.project.createrId, projectId: $scope.project.id});
    }, function (errors) {
      var errors = errors.data;

      angular.forEach(errors, function (error, field) {
          $scope.ProjectExecuter.$setValidity(field, false, $scope.email);
          var serverMessage = $parse('ProjectExecuter.'+field+'.$error.serverMessage');
          serverMessage.assign($scope, error.join(', '));
      });
    });
  }

  Project.get($stateParams.projectId).then(function (result) {
    $scope.project = result;
  });
}]);
