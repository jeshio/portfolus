angular.module('portfolus')
.controller('CreateOrderProjectCtrl',['$scope', 'OrderProject', '$parse', 'Category', '$state',
function($scope, OrderProject, $parse, Category, $state){
  // объект для формы
  $scope.orderProject = {};
  $scope.technology = {};
  $scope.orderProject.tags = [];
  $scope.orderProject.technologies = [];
  $scope.categories = [];

  // создать объект
  $scope.createOrderProject = function () {
    var orderProject = new OrderProject($scope.orderProject);
    orderProject.create().then(function (result) {
      $state.go('orderProjectDetail', {orderProjectId: result.id});
    }, function (errors) {
      console.log(errors);
      var errors = errors.data;

      angular.forEach(errors, function (error, field) {
          $scope.OrderProject.$setValidity(field, false, $scope.email);
          var serverMessage = $parse('OrderProject.'+field+'.$error.serverMessage');
          serverMessage.assign($scope, error.join(', '));
      });
    });
  }

  $scope.addTehnology = function () {
    resetValidation('Technology');
    $scope.orderProject.technologies.push(angular.copy($scope.technology));
    $scope.technology = {};
  }

  $scope.deleteTech = function (technology) {
    $scope.project.technologies.splice( $scope.project.technologies.indexOf(technology), 1 );
  }

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
