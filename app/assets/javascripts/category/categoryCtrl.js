angular.module('portfolus')
.controller('CategoriesCtrl',
function($scope, Category){
  $scope.Category = Category.query().then(function (result) {
    $scope.categories = result;
  });
});
