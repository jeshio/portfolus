angular.module('portfolus').controller 'CreateProjectExecuterCtrl', [
  '$scope'
  'ProjectExecuter'
  'Project'
  '$stateParams'
  '$state'
  '$parse'
  ($scope, ProjectExecuter, Project, $stateParams, $state, $parse) ->
    $scope.projectExecuter = project_id: $stateParams.projectId
    $scope.project = {}

    $scope.addProjectExecuter = ->
      projectExecuter = new ProjectExecuter($scope.projectExecuter)
      projectExecuter.create().then ((result) ->
        $state.go 'projectDetail',
          executerId: $scope.project.createrId
          projectId: $scope.project.id
      ), (errors) ->
        `var errors`
        errors = errors.data
        angular.forEach errors, (error, field) ->
          $scope.ProjectExecuter.$setValidity field, false, $scope.email
          serverMessage = $parse('ProjectExecuter.' + field + '.$error.serverMessage')
          serverMessage.assign $scope, error.join(', ')

    Project.get($stateParams.projectId).then (result) ->
      $scope.project = result
]
