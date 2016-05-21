angular.module('portfolus')
.controller('ProjectCtrl',
function($scope, Project, User){
  User.getAllProjects($scope.authUser.id).then(function (result) {
    $scope.projects = result;
  });

  $scope.create = function () {
    console.log($scope.project);
  }
});
