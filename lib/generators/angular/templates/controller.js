angular.module('portfolus')
.controller('<%= file_name.camelize %>Ctrl',['$scope', '<%= file_name.camelize %>', '$mdDialog', '$mdMedia', '$mdToast',
function($scope, <%= file_name.camelize %>, $mdDialog, $mdMedia, $mdToast){
  // список
  $scope.<%= file_name.pluralize(2) %> = [];

  load<%= file_name.camelize.pluralize(2) %>();


  // удаление
  $scope.delete = function (<%= file_name %>, ev) {
    var confirm = $mdDialog.confirm()
          .title('Удалить?')
          .ariaLabel('Процесс удаления записи.')
          .targetEvent(ev)
          .ok('Да')
          .cancel('Нет');
    $mdDialog.show(confirm).then(function() {
      new <%= file_name.camelize %>(<%= file_name %>).delete().then(function (result) {
        $mdToast.show($mdToast.simple().textContent('Удалено.'));
        load<%= file_name.camelize.pluralize(2) %>();
      });
    });
  }

  // запрос списка
  function load<%= file_name.camelize.pluralize(2) %>() {
    <%= file_name.camelize %>.query().then(function (result) {
      $scope.<%= file_name.pluralize(2) %> = result;
    });
  };
}]);
