angular.module('portfolus')
.controller('SearchCtrl',['$scope', 'Search', '$location', 'cities',
function($scope, Search, $location, cities){
  $scope.searches = [];
  $scope.cities = [];
  cities.forEach(function (element, index) {
    $scope.cities[index] = element;
  });

  update();

  $scope.$watch(function(){ return $location.search() }, function(params){
    update();
  });

  function update() {
    var search = $location.search();

    // запрашивает данные с применением фильтров
    Search.query(search).then(function (data) {
      $scope.searches = data;
    }, function () {
      $scope.searches = [];
    });

    $scope.listSrc = "search/lists/_"+search.type+".html";
  }

}]);
