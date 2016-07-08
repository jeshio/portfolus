angular.module('portfolus').controller 'HomeCtrl', [
  '$scope'
  '$http'
  ($scope, $http) ->
    $scope.commits = []
    $http(url: '/api/get_commits')
    .success (data) ->
      $scope.commits = data
    .error (status) ->
      console.log status
]
