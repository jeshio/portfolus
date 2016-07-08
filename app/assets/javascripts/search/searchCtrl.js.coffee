angular.module('portfolus').controller 'SearchCtrl', [
  '$scope'
  'Search'
  '$location'
  '$rootScope'
  '$window'
  ($scope, Search, $location, $rootScope, $window) ->

    update = ->
      search = $location.search()
      # запрашивает данные с применением фильтров
      switch search.type
        when 'executers'
          Search.executers(search).then ((data) ->
            $scope.searches = splitParts(data, 3)
          ), ->
            $scope.searches = []
        when 'projects'
          Search.projects(search).then ((data) ->
            $scope.searches = splitParts(data, 3)
          ), (errors) ->
            console.log errors
            $scope.searches = []
        when 'orders'
          Search.orders(search).then ((data) ->
            console.log data
            $scope.searches = splitParts(data, 3)
          ), (errors) ->
            console.log errors
            $scope.searches = []
        else
          $scope.searches = []
      $scope.listSrc = 'search/lists/_' + search.type + '.html'

    splitParts = (data, chunk) ->
      # разделение данных на партии по chunk штук для колонок
      parts = []
      i = 0
      j = data.length
      while i < j
        parts.push data.slice(i, i + chunk)
        i += chunk
      parts

    $scope.searches = []
    $scope.cardUser = {}
    # получение события обновления фильтров
    $rootScope.$on 'applyFilters', (event, args) ->
      update()
    $scope.listStyle = height: self.parent.innerHeight - 66 + 'px'
    $window.addEventListener 'resize', ->
      $scope.listStyle = height: self.parent.innerHeight - 66 + 'px'
      $scope.$digest()
]
