angular.module('portfolus')
.controller('ProjectDetailCtrl',['$scope', 'Project', '$stateParams', '$mdDialog', '$mdMedia', 'ProjectExecuter',
function($scope, Project, $stateParams, $mdDialog, $mdMedia, ProjectExecuter){
  $scope.project = {};

  Project.get($stateParams.id).then(function (result) {
    $scope.project = result;
  });

  $scope.confirm = function(ev, project) {
    var useFullScreen = ($mdMedia('sm') || $mdMedia('xs')) && $scope.customFullscreen;
    $mdDialog.show({
      templateUrl: 'project/_dialog.html',
      controller: function ProjectDialogController($scope, $mdDialog, project) {
        $scope.project = project;
        $scope.hide = function() {
          $mdDialog.hide();
        };
      },
      parent: angular.element(document.body),
      targetEvent: ev,
      locals: {project: project},
      clickOutsideToClose:true,
      fullscreen: useFullScreen
    }).then(function() {
   });

    $scope.$watch(function() {
      return $mdMedia('xs') || $mdMedia('sm');
    }, function(wantsFullScreen) {
      $scope.customFullscreen = (wantsFullScreen === true);
    });
  };
}]);
