angular.module('portfolus')
.controller('UpdateOrderProjectCtrl',['$scope', 'OrderProject', '$parse', '$stateParams',
function($scope, OrderProject, $parse, $stateParams){
  // объект для формы
  $scope.orderProject = {};
  // кнопка отправки - обновить
  $scope.updates = true;

  // создать объект
  $scope.updateOrderProject = function () {
    var orderProject = new OrderProject($scope.orderProject);
    orderProject.update().then(function (result) {
      $state.go('orderProjects');
    }, function (errors) {
      var errors = errors.data;

      angular.forEach(errors, function (error, field) {
          $scope.OrderProject.$setValidity(field, false, $scope.email);
          var serverMessage = $parse('OrderProject.'+field+'.$error.serverMessage');
          serverMessage.assign($scope, error.join(', '));
      });
    });
  }

  OrderProject.get($stateParams.orderProjectId).then(function (result) {
    $scope.orderProject = result;
  });
}]);
