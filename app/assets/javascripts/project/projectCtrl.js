angular.module('portfolus')
.controller('ProjectCtrl',['$scope', 'Project', 'User', 'Category', '$mdConstant', '$mdMedia', '$mdDialog', '$state', '$parse',
function($scope, Project, User, Category, $mdConstant, $mdMedia, $mdDialog, $state, $parse){
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
    }, function (errors) {
      angular.forEach(errors.data.errors, function (model, modelName) {
        angular.forEach(model, function (error, field) {
          modelNameUp = modelName.charAt(0).toUpperCase() + modelName.substr(1).toLowerCase();
          $scope[modelNameUp].$setValidity(field, false, $scope.project);
          var serverMessage = $parse(modelNameUp+'.'+field+'.$error.serverMessage');
          serverMessage.assign($scope, error.join(', '));
        });
      });
    });
  };

  $scope.addTehnology = function () {
    resetValidation('Technology');
    $scope.project.technologies.push(angular.copy($scope.technology));
    $scope.technology = {};
  }

  $scope.deleteTech = function (technology) {
    $scope.project.technologies.splice( $scope.project.technologies.indexOf(technology), 1 );
  }

  $scope.showDetail = function(ev, project) {
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

  function resetValidation(form) {
    $scope[form].$setPristine();
    $scope[form].$setValidity();
    $scope[form].$setUntouched();
    $scope[form].$error = {};
  }
}]);
