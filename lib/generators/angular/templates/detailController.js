angular.module('portfolus')
.controller('Detail<%= file_name.camelize %>Ctrl',['$scope', '<%= file_name.camelize %>', '$parse', '$state', '$stateParams', '$mdDialog', '$mdMedia', '$mdToast',
function($scope, <%= file_name.camelize %>, $parse, $state, $stateParams, $mdDialog, $mdMedia, $mdToast){
  // объект для формы
  $scope.<%= file_name %> = {};

  // обновить объект
  $scope.update<%= file_name.camelize %> = function () {
    var <%= file_name %> = new <%= file_name.camelize %>($scope.<%= file_name %>);
    <%= file_name %>.update().then(function (result) {
      $state.go('<%= file_name.pluralize(2) %>');
    }, function (errors) {
      var errors = errors.data;

      angular.forEach(errors, function (error, field) {
          $scope.<%= file_name.camelize %>.$setValidity(field, false, $scope.email);
          var serverMessage = $parse('<%= file_name.camelize %>.'+field+'.$error.serverMessage');
          serverMessage.assign($scope, error.join(', '));
      });
    });
  }

  // удаление
  $scope.delete = function (ev) {
    var confirm = $mdDialog.confirm()
          .title('Удалить?')
          .ariaLabel('Удаление записи.')
          .targetEvent(ev)
          .ok('Да')
          .cancel('Нет');
    $mdDialog.show(confirm).then(function() {
      $scope.<%= file_name %>.delete().then(function (result) {
        $mdToast.show($mdToast.simple().textContent('Удалено.'));
        $state.go('<%= file_name.pluralize(2) %>');
      });
    });
  }

  <%= file_name.camelize %>.get($stateParams.<%= file_name %>Id).then(function (result) {
    $scope.<%= file_name %> = result;
  });
}]);
