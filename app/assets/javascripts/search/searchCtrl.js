angular.module('portfolus')
.controller('SearchCtrl',['$scope', 'Search', '$location', 'cities', '$rootScope', '$window',
function($scope, Search, $location, cities, $rootScope, $window){
  $scope.searches = [];
  $scope.cities = [];
  cities.forEach(function (element, index) {
    $scope.cities[element.id] = element;
  });

  // получение события обновления фильтров
  $rootScope.$on('appleFilters', function(event, args){
    update();
  });

  $scope.listStyle = {
      height: (self.parent.innerHeight - 66) + 'px'
    };
  $window.addEventListener('resize', function () {
    $scope.listStyle = {
      height: (self.parent.innerHeight - 66) + 'px'
    };
    $scope.$digest();
  });

  console.log(document.querySelectorAll('#top-menu-list')[0].parentNode.offsetHeight);

  function update() {
    var search = $location.search();

    // запрашивает данные с применением фильтров
    Search.query(search).then(function (data) {
      // разделение данных на партии по 3 штуки для колонок
      var parts = [], chunk = 3;
      for (var i = 0, j = data.length; i < j; i += chunk) {
          parts.push(data.slice(i, i + chunk));
      }
      $scope.searches = parts;
    }, function () {
      $scope.searches = [];
    });

    $scope.listSrc = "search/lists/_"+search.type+".html";
  }

}]);
