angular.module('portfolus')
.controller('SearchFilterCtrl',['$scope', 'Search', '$location', 'City', 'cities', '$rootScope',
function($scope, Search, $location, City, cities, $rootScope){
  $scope.filterBlock = "";
  getSearch();

  $scope.cities = cities;

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
    $rootScope.$broadcast('appleFilters', []);
  }

  // применить изменения запроса для типа поиска
  function updateSearch() {
    $location.search(angular.extend($scope.filters, {type: $scope.type}));

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
    $scope.filters = filters;
    updateSearch();
  }
}]);
