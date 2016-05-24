angular.module('portfolus')
.controller('AuthCtrl', ['$scope', '$state', '$parse', 'Auth', 'City',
function($scope, $state, $parse, Auth, City){

  // пошаговая регистрация
  $scope.max = 2;
  $scope.selectedIndex = 0;
  $scope.user = {}
  $scope.cities = [];

  City.query().then(function (result) {
    $scope.cities = result;
  });

  $scope.nextTab = function() {
    var index = ($scope.selectedIndex == $scope.max) ? 0 : $scope.selectedIndex + 1;
    $scope.selectedIndex = index;
  };

  var config = {
    headers: {
      'X-HTTP-Method-Override': 'POST'
    }
  };

  $scope.login = function() {
    Auth.login($scope.user, config).then(function(user){
      $state.go('user', {id: user.id});
    }, function(data) {
      $scope.errors = { authError: "authError" };
    });
  };

  $scope.register = function() {
    console.log($scope.user);
    Auth.register($scope.user).then(function(user){
      $state.go('user', {id: user.id});
    }, function(data) {
      // обработка ошибок с серверной стороны
      var errors = data.data.errors;

      angular.forEach(errors, function (error, field) {
          $scope.User.$setValidity(field, false, $scope.user);
          var serverMessage = $parse('User.'+field+'.$error.serverMessage');
          serverMessage.assign($scope, error.join(', '));
      });

      $scope.selectedIndex = 0;
    });

  };
}]);
