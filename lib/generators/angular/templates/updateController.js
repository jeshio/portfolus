angular.module('portfolus')
.controller('Update<%= file_name.camelize %>Ctrl',['$scope', '<%= file_name.camelize %>', '$parse', '$state', '$stateParams',
function($scope, <%= file_name.camelize %>, $parse, $state, $stateParams){
  // объект для формы
  $scope.<%= file_name %> = {};

  // создать объект
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

  <%= file_name.camelize %>.get($stateParams.<%= file_name %>Id).then(function (result) {
    $scope.<%= file_name %> = result;
  });
}]);
