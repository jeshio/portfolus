angular.module('portfolus').controller 'SearchFilterCtrl', [
  '$scope'
  'Search'
  '$location'
  'categories'
  'cities'
  '$rootScope'
  ($scope, Search, $location, categories, cities, $rootScope) ->
    # применить изменения запроса для типа поиска

    updateSearch = ->
      # FIXME если в массиве одна строка, после обновления страницы она будет рассмотрена как массив
      $location.search angular.extend($scope.filters, { type: $scope.type }, { 'tags[]': $scope.tags }, 'technologies[]': $scope.technologies)
      if $scope.type.length > 0
        $scope.filterBlock = 'search/filters/_' + $scope.type + '.html'

    # значения по умолчанию

    getSearch = ->
      search = $location.search()
      $scope.type = search.type or 'executers'
      filters = search or {}
      # фиксы
      `filters.min_projects != undefined` and (filters.min_projects = parseInt(filters.min_projects, 0))
      `filters['tags[]'] != undefined` and ($scope.tags = filters['tags[]'])
      `filters['technologies[]'] != undefined` and ($scope.technologies = filters['technologies[]'])
      $scope.filters = filters
      updateSearch()

    $scope.filterBlock = ''
    $scope.cities = cities
    $scope.categories = categories
    $scope.filters = {}
    $scope.tags = []
    $scope.technologies = []
    getSearch()
    # устанавка активности для кновок выбора типа

    $scope.getTypeClass = (type) ->
      if type is $scope.type then 'active' else ''

    # тип искомых объектов

    $scope.setType = (type) ->
      $scope.type = type
      updateSearch()

    $scope.update = ->
      updateSearch()
      $rootScope.$broadcast 'applyFilters', []
]
