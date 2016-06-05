angular.module('portfolus')
.controller('ProjectDetailCtrl',['$scope', 'Project', '$stateParams', '$mdDialog', '$mdMedia', 'ProjectExecuter', 'ProjectConfirm', '$mdToast',
function($scope, Project, $stateParams, $mdDialog, $mdMedia, ProjectExecuter, ProjectConfirm, $mdToast){
  $scope.project = {};
  $scope.executerId = $stateParams.executerId;
  $scope.confirm = {}; // подтверждение текущия пользователем
  $scope.confirmers = []; // список подтвердивших

  loadProject();

  if ($scope.signedIn) {
      // диалог подтверждения проекта
    $scope.setConfirm = function(ev) {
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
            loadProject();
        }, function (error) {
          var listError = "";
          angular.forEach(error.data, function (val, key) {
            listError += key + " " + val.join(', ') + "; ";
          });
          $mdToast.show($mdToast.simple().textContent("Ошибка подтверждения: " + listError));
        });

      });
    };

    // диалог отмены подтверждения
    $scope.unconfirm = function(ev) {
      // Appending dialog to document.body to cover sidenav in docs app
      var confirm = $mdDialog.confirm()
            .title('Отменить подтверждение?')
            .textContent('Положительный ответ отменит ваше подтверждение участия пользователя в проекте.')
            .ariaLabel('Отмена подтверждения')
            .targetEvent(ev)
            .ok('Да')
            .cancel('Нет');
      $mdDialog.show(confirm).then(function() {
        var confirmId = $scope.confirm.id;
        $scope.confirm = undefined;
        new ProjectConfirm({id: confirmId}).delete().then(function (result) {
          $mdToast.show($mdToast.simple().textContent('Подтверждение отменено!'));
          loadProject();
        });

      });
    };
  }

  function loadProject() {
    // TODO нужна защита от просмотра чужих проектов через id пользователя
    // загружаем проект со списком подтверждений
    Project.getDetail({id: $stateParams.projectId, executer_id: $scope.executerId}).then(function (result) {
      $scope.project = result;

      if ($scope.signedIn)
        // загружаем подтверждение
        ProjectConfirm.searchWithProjectAndUser($scope.project.id, $scope.executerId,
          $scope.authUser.id).then(function (data) {
            $scope.confirm = data;
        });
    });
  }
}]);
