angular.module('portfolus')
.controller('ProjectCtrl',
function($scope, Project, User, Category, $mdConstant, $mdMedia, $mdDialog, $state){
  $scope.project = {};
  $scope.technology = {};
  $scope.project.tags = [];
  $scope.project.technologies = [];

  User.getAllProjects($scope.authUser.id).then(function (result) {
    $scope.projects = result;
  });

  Category.query().then(function (result) {
    $scope.categories = result;
  });

  $scope.create = function () {
    new Project($scope.project).create().then(function (data) {
      $state.go('projects');
    }, function (error) {
      // TODO errors
      console.log(error);
    });
  }

  $scope.addTehnology = function () {
    $scope.project.technologies.push(angular.copy($scope.technology));
    $scope.technology = {};
  }

  $scope.deleteTech = function (technology) {
    $scope.project.technologies.splice( $scope.project.technologies.indexOf(technology), 1 );
  }

  $scope.showDetail = function(ev, project) {
    var useFullScreen = ($mdMedia('sm') || $mdMedia('xs')) && $scope.customFullscreen;
    $mdDialog.show({
      templateUrl: 'project/_detail.html',
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
});
