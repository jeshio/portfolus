angular.module('portfolus')
.controller('<%= file_name.capitalize.pluralize(2) %>Ctrl',['$scope', '<%= file_name.capitalize %>',
function($scope, <%= file_name.capitalize %>){
  $scope.<%= file_name.capitalize %> = <%= file_name.capitalize %>.query().then(function (result) {
    $scope.<%= file_name.pluralize(2) %> = result;
  });
}]);
