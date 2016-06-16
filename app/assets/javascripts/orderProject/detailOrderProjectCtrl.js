angular.module('portfolus')
.controller('DetailOrderProjectCtrl',['$scope', 'OrderProject', '$parse', '$state', '$stateParams', '$mdDialog', '$mdMedia', '$mdToast', 'Category',
function($scope, OrderProject, $parse, $state, $stateParams, $mdDialog, $mdMedia, $mdToast, Category){
  // объект для формы
  $scope.orderProject = {};
  $scope.technology = {};
  $scope.orderProject.tags = [];
  $scope.orderProject.technologies = [];
  $scope.categories = [];

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

  // удаление
  $scope.delete = function (ev) {
    var confirm = $mdDialog.confirm()
          .title('Удалить?')
          .ariaLabel('Удаление записи.')
          .targetEvent(ev)
          .ok('Да')
          .cancel('Нет');
    $mdDialog.show(confirm).then(function() {
      $scope.orderProject.delete().then(function (result) {
        $mdToast.show($mdToast.simple().textContent('Удалено.'));
        $state.go('orderProjects');
      });
    });
  }

  OrderProject.get($stateParams.orderProjectId).then(function (result) {
    $scope.orderProject = result;
  });

  Category.query().then(function (result) {
    $scope.categories = result;
  });

  function resetValidation(form) {
    $scope[form].$setPristine();
    $scope[form].$setValidity();
    $scope[form].$setUntouched();
    $scope[form].$error = {};
  }
}]);
