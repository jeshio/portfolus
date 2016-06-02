angular.module('portfolus')
.controller('ProjectConfirmCtrl',['$scope', 'ProjectConfirm',
function($scope, ProjectConfirm){
  $scope.projectConfirms = [];
  ProjectConfirm.query().then(function (result) {
    $scope.projectConfirms = result;
  });
}]);
