angular.module('portfolus').controller 'ProjectConfirmCtrl', [
  '$scope'
  'ProjectConfirm'
  ($scope, ProjectConfirm) ->
    $scope.projectConfirms = []
    ProjectConfirm.query().then (result) ->
      $scope.projectConfirms = result
]
