angular.module('portfolus').controller 'ProjectExecuterCtrl', [
  '$scope'
  'ProjectExecuter'
  '$stateParams'
  '$state'
  ($scope, ProjectExecuter, $stateParams, $state) ->
    $scope.projectExecuter = {}
    $scope.project = {}
    ProjectExecuter.get($stateParams.projectExecuterId).then (result) ->
      $scope.projectExecuter = result
      $scope.project = result.project

    $scope.updateProjectExecuter = ->
      $scope.projectExecuter.executer_confirmed = true
      new ProjectExecuter($scope.projectExecuter).update().then ->
        $state.go 'projectDetail',
          executerId: $scope.project.createrId
          projectId: $scope.project.id
]
