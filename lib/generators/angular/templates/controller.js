angular.module('portfolus')
.controller('<%= file_name.camelize %>Ctrl',['$scope', '<%= file_name.camelize %>',
function($scope, <%= file_name.camelize %>){
  $scope.<%= file_name.pluralize(2) %> = [];
  <%= file_name.camelize %>.query().then(function (result) {
    $scope.<%= file_name.pluralize(2) %> = result;
  });
}]);
