angular.module('portfolus')
.controller('SearchFilterCtrl',['$scope', 'Search', '$location', 'categories', 'cities', '$rootScope',
function($scope, Search, $location, categories, cities, $rootScope){
  $scope.filterBlock = "";

  $scope.cities = cities;
  $scope.categories = categories;

  $scope.filters = {};
  $scope.tags = [];
  $scope.technologies = [];
  getSearch();

  // устанавка активности для кновок выбора типа
  $scope.getTypeClass = function (type) {
    return type == $scope.type ? 'active' : '';
  }

  // тип искомых объектов
  $scope.setType = function(type) {
    $scope.type = type;
    updateSearch();
  };

  $scope.update = function () {
    updateSearch();
    $rootScope.$broadcast('applyFilters', []);
  }

  // применить изменения запроса для типа поиска
  function updateSearch() {
    // FIXME если в массиве одна строка, после обновления страницы она будет рассмотрена как массив
    $location.search(angular.extend($scope.filters, {type: $scope.type}, {'tags[]': $scope.tags}, {'technologies[]': $scope.technologies}));

    if($scope.type.length > 0)
      $scope.filterBlock = "search/filters/_"+$scope.type+".html";
  }

  // значения по умолчанию
  function getSearch() {
    var search = $location.search();
    $scope.type = search.type || "executers";

    var filters = search || {};

    // фиксы
    filters.min_projects !== undefined && (filters.min_projects = parseInt(filters.min_projects, 0));
    filters["tags[]"] !== undefined && ($scope.tags = filters["tags[]"]);
    filters["technologies[]"] !== undefined && ($scope.technologies = filters["technologies[]"]);
    $scope.filters = filters;
    updateSearch();
  }
}]);
