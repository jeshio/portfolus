angular.module('portfolus')
.controller('CategoriesCtrl',['$scope', 'Category',
function($scope, Category){
  $scope.Category = Category.query().then(function (result) {
    $scope.categories = result;
  });
}]);
