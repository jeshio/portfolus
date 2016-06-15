angular.module('portfolus')
.controller('Create<%= file_name.camelize %>Ctrl',['$scope', '<%= file_name.camelize %>', '$parse', '$state',
function($scope, <%= file_name.camelize %>, $parse, $state){
  // объект для формы
  $scope.<%= file_name %> = {};

  // создать объект
  $scope.create<%= file_name.camelize %> = function () {
    var <%= file_name %> = new <%= file_name.camelize %>($scope.<%= file_name %>);
    <%= file_name %>.create().then(function (result) {
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
}]);
