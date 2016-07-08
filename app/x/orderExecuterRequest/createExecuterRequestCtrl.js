angular.module('portfolus')
.controller('CreateOrderExecuterRequestCtrl',['$scope', 'OrderExecuterRequest', '$parse', '$state',
function($scope, OrderExecuterRequest, $parse, $state){
  // объект для формы
  $scope.orderExecuterRequest = { byCustomer: false };

  // создать объект
  $scope.createOrderExecuterRequest = function () {
    var orderExecuterRequest = new OrderExecuterRequest($scope.orderExecuterRequest);
    orderExecuterRequest.create().then(function (result) {
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
}]);
