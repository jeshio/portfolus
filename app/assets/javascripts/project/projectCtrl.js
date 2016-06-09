angular.module('portfolus')
.controller('ProjectCtrl',['$scope', 'Project', 'User', 'Category', '$mdConstant', '$mdMedia', '$mdDialog', '$state', '$parse', 'ProjectExecuter', '$mdToast',
function($scope, Project, User, Category, $mdConstant, $mdMedia, $mdDialog, $state, $parse, ProjectExecuter, $mdToast){
  $scope.project = {};
  $scope.technology = {};
  $scope.project.tags = [];
  $scope.project.technologies = [];
  $scope.project.partners = [];
  $scope.confirmers = []; // список подтвердивших

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
      controller: function ProjectDialogController($scope, $mdDialog, project, userId) {
        $scope.project = project;
        $scope.userId = userId;
        $scope.hide = function() {
          $mdDialog.hide();
        };
      },
      parent: angular.element(document.body),
      targetEvent: ev,
      locals: {project: project, userId: $scope.authUser.id},
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

  // сообщения об участии
  $scope.showExecuterRequests = function (ev) {
    var useFullScreen = ($mdMedia('sm') || $mdMedia('xs')) && $scope.customFullscreen;
    $mdDialog.show({
      templateUrl: 'projectExecuter/tmpl/_dialogExecuterRequests.html',
      controller: function ExecuterRequestsDialogController($scope, $mdDialog, authUser, User, ProjectExecuter) {
        $scope.authUser = authUser;
        loadRequests();

        $scope.deleteExecuter = function (executer) {
          new ProjectExecuter(executer).delete().then(function () {
            $mdToast.show($mdToast.simple().textContent('Запрос отклонён.'));
            loadRequests();
          });
        }

        $scope.acceptExecuter = function (executer) {
          executer.creater_confirmed = true;
          new ProjectExecuter(executer).update().then(function () {
            $mdToast.show($mdToast.simple().textContent('Запрос об участии принят.'));
            loadRequests();
          });
        }

        function loadRequests() {
          User.get(authUser.id).then(function (result) {
            result.executerRequests().then(function (requests) {
              console.log(requests);
              $scope.requestedProjects = requests;
            });
          });
        }

        $scope.hide = function() {
          $mdDialog.hide();
        };
      },
      parent: angular.element(document.body),
      targetEvent: ev,
      locals: {authUser: $scope.authUser},
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
