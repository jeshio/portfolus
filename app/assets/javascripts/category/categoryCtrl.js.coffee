angular.module('portfolus').controller 'CategoriesCtrl', [
  '$scope'
  'Category'
  ($scope, Category) ->
    $scope.Category = Category.query().then((result) ->
      $scope.categories = result
    )
]
