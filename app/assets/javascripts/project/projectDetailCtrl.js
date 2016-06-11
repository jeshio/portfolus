angular.module('portfolus')
.controller('ProjectDetailCtrl',['$scope', 'Project', '$stateParams', '$mdDialog', '$mdMedia', 'ProjectExecuter', 'ProjectConfirm', '$mdToast', '$filter', '$stateParams',
function($scope, Project, $stateParams, $mdDialog, $mdMedia, ProjectExecuter, ProjectConfirm, $mdToast, $filter, $stateParams){
  $scope.project = {};
  $scope.executerId = $stateParams.executerId;
  $scope.confirm = {}; // подтверждение текущия пользователем
  $scope.confirmers = []; // список подтвердивших
  $scope.userExecuter = {}; // текущий пользователь, исполнитель текущего проекта
  $scope.userId = $stateParams.executerId;

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

    // диалог - убрать из участников
    $scope.removeExecuter = function (ev) {
      // Appending dialog to document.body to cover sidenav in docs app
      var confirm = $mdDialog.confirm()
            .title('Убрать вас из списка участников?')
            .textContent('Вы будете исключены из списка участников')
            .ariaLabel('Убрать вас из списка участников')
            .targetEvent(ev)
            .ok('Да')
            .cancel('Нет');
      $mdDialog.show(confirm).then(function() {
        new ProjectExecuter({id: $scope.userExecuter.id}).delete().then(function (result) {
          $mdToast.show($mdToast.simple().textContent('Вы убраны из списка участников!'));
          loadProject();
        });
      });
    }
  }

  function loadProject() {
    // TODO нужна защита от просмотра чужих проектов через id пользователя
    // загружаем проект со списком подтверждений
    Project.getDetail({id: $stateParams.projectId, executer_id: $scope.executerId}).then(function (result) {
      $scope.project = result;

      if ($scope.signedIn) {
        // загружаем подтверждение
        ProjectConfirm.searchWithProjectAndUser($scope.project.id, $scope.executerId,
          $scope.authUser.id).then(function (data) {
            $scope.confirm = data;
        });

        ProjectExecuter.query({executerId: $scope.authUser.id, projectId: $scope.project.id}).then(function (result) {
          $scope.userExecuter = result[0];
        });
      }
    });
  }
}]);
