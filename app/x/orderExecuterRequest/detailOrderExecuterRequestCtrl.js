angular.module('portfolus')
.controller('DetailOrderExecuterRequestCtrl',['$scope', 'OrderExecuterRequest', '$parse', '$state', '$stateParams', '$mdDialog', '$mdMedia', '$mdToast',
function($scope, OrderExecuterRequest, $parse, $state, $stateParams, $mdDialog, $mdMedia, $mdToast){
  // объект для формы
  $scope.orderExecuterRequest = {};

  // создать объект
  $scope.updateOrderExecuterRequest = function () {
    var orderExecuterRequest = new OrderExecuterRequest($scope.orderExecuterRequest);
    orderExecuterRequest.update().then(function (result) {
      $state.go('orderExecuterRequests');
    }, function (errors) {
      var errors = errors.data;

      angular.forEach(errors, function (error, field) {
          $scope.OrderExecuterRequest.$setValidity(field, false, $scope.email);
          var serverMessage = $parse('OrderExecuterRequest.'+field+'.$error.serverMessage');
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
      $scope.orderExecuterRequest.delete().then(function (result) {
        $mdToast.show($mdToast.simple().textContent('Удалено.'));
        $state.go('orderExecuterRequests');
      });
    });
  }

  OrderExecuterRequest.get($stateParams.orderExecuterRequestId).then(function (result) {
    $scope.orderExecuterRequest = result;
  });
}]);
