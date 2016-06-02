angular.module('portfolus')
.controller('ProjectDetailCtrl',['$scope', 'Project', '$stateParams', '$mdDialog', '$mdMedia', 'ProjectExecuter', 'ProjectConfirm', '$mdToast',
function($scope, Project, $stateParams, $mdDialog, $mdMedia, ProjectExecuter, ProjectConfirm, $mdToast){
  $scope.project = {};
  $scope.executerId = $stateParams.executerId;

  // TODO нужна защита от просмотра чужих проектов через id пользователя
  Project.get($stateParams.projectId).then(function (result) {
    $scope.project = result;
  });

  $scope.confirm = function(ev) {
    // Appending dialog to document.body to cover sidenav in docs app
    var confirm = $mdDialog.prompt()
          .title('Хотите подтвердить участие пользователя в проекте?')
          .textContent('Напишите комментарий по этому поводу.')
          .placeholder('комментарий')
          .ariaLabel('Комментарий')
          .targetEvent(ev)
          .ok('Подтвердить!')
          .cancel('Отменить');
    $mdDialog.show(confirm).then(function(result) {

      // создание подтверждения
      ProjectConfirm.createWithProjectAndUser($scope.project.id, $scope.executerId,
        $scope.authUser.id, result).then(function (result) {
          $mdToast.show($mdToast.simple().textContent('Подтверждено!'));
      }, function (error) {
        var listError = "";
        angular.forEach(error.data, function (val, key) {
          listError += key + " " + val.join(', ') + "; ";
        });
        $mdToast.show($mdToast.simple().textContent("Ошибка подтверждения: " + listError));
      });

    });
  };
  // function(ev, project, userId) {
  //   var useFullScreen = ($mdMedia('sm') || $mdMedia('xs')) && $scope.customFullscreen;
  //   $mdDialog.show({
  //     templateUrl: 'projectExecuter/tmpl/_dialog.html',
  //     controller: function ProjectExecuterDialogController($scope, $mdDialog, project, userId, ProjectExecuter, User) {
  //       $scope.project = project;
  //       $scope.executer = {};
  //
  //       User.get(userId).then(function (result) {
  //         $scope.executer = result;
  //       }, function (error) {
  //         console.log(error);
  //       });
  //
  //       $scope.hide = function() {
  //         $mdDialog.hide();
  //       };
  //     },
  //     parent: angular.element(document.body),
  //     targetEvent: ev,
  //     locals: {project: project},
  //     clickOutsideToClose:true,
  //     fullscreen: useFullScreen
  //   }).then(function() {
  //  });
  //
  //   $scope.$watch(function() {
  //     return $mdMedia('xs') || $mdMedia('sm');
  //   }, function(wantsFullScreen) {
  //     $scope.customFullscreen = (wantsFullScreen === true);
  //   });
  // };
}]);
