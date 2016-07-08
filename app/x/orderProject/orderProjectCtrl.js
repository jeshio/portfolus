angular.module('portfolus')
.controller('OrderProjectCtrl',['$scope', 'OrderProject', '$mdDialog', '$mdMedia', '$mdToast', 'User',
function($scope, OrderProject, $mdDialog, $mdMedia, $mdToast, User){
  // список
  $scope.orderProjects = [];

  loadOrderProjects();


  // удаление
  $scope.delete = function (orderProject, ev) {
    var confirm = $mdDialog.confirm()
          .title('Удалить?')
          .ariaLabel('Процесс удаления записи.')
          .targetEvent(ev)
          .ok('Да')
          .cancel('Нет');
    $mdDialog.show(confirm).then(function() {
      new OrderProject(orderProject).delete().then(function (result) {
        $mdToast.show($mdToast.simple().textContent('Удалено.'));
        loadOrderProjects();
      });
    });
  }

  // запрос списка
  function loadOrderProjects() {
    User.get($scope.authUser.id).then(function (result) {
      result.orderProjects().then(function (projects) {
        $scope.orderProjects = projects;
      });
    });
  };
}]);
