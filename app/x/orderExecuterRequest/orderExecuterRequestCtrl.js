angular.module('portfolus')
.controller('OrderExecuterRequestCtrl',['$scope', 'OrderExecuterRequest', '$mdDialog', '$mdMedia', '$mdToast', 'User',
function($scope, OrderExecuterRequest, $mdDialog, $mdMedia, $mdToast, User) {
  // список
  $scope.orderExecuterRequests = [];

  loadOrderExecuterRequests();


  // удаление
  $scope.delete = function (orderExecuterRequest, ev) {
    var confirm = $mdDialog.confirm()
          .title('Удалить?')
          .ariaLabel('Процесс удаления записи.')
          .targetEvent(ev)
          .ok('Да')
          .cancel('Нет');
    $mdDialog.show(confirm).then(function() {
      new OrderExecuterRequest(orderExecuterRequest).delete().then(function (result) {
        $mdToast.show($mdToast.simple().textContent('Удалено.'));
        loadOrderExecuterRequests();
      });
    });
  }

  // запрос списка
  function loadOrderExecuterRequests() {
    User.get($scope.authUser.id).then(function (result) {
      result.orderExecuterRequests().then(function (result) {
        $scope.orderExecuterRequests = result;
      });
    });
  };
}]);
