angular.module('portfolus')
.controller('SearchCtrl',['$scope', 'Search', '$location', '$rootScope', '$window',
function($scope, Search, $location, $rootScope, $window){
  $scope.searches = [];
  $scope.cardUser = {};

  // получение события обновления фильтров
  $rootScope.$on('applyFilters', function(event, args){
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

  function update() {
    var search = $location.search();

    // запрашивает данные с применением фильтров
    switch (search.type) {
      case "executers":
        Search.executers(search).then(function (data) {
          $scope.searches = splitParts(data);
        }, function () {
          $scope.searches = [];
        });
        break;
      case "projects":
        Search.projects(search).then(function (data) {
          $scope.searches = splitParts(data);
        }, function (errors) {
          console.log(errors);
          $scope.searches = [];
        });
        break;
      case "orders":
        Search.orders(search).then(function (data) {
          console.log(data);
          $scope.searches = splitParts(data);
        }, function (errors) {
          console.log(errors);
          $scope.searches = [];
        });
        break;
      default:
      $scope.searches = [];
    }

    $scope.listSrc = "search/lists/_"+search.type+".html";
  }

  function splitParts(data, chunk = 3) {
    // разделение данных на партии по chunk штук для колонок
    var parts = [];
    for (var i = 0, j = data.length; i < j; i += chunk) {
        parts.push(data.slice(i, i + chunk));
    }
    return parts;
  }

}]);
