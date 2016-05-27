angular.module('rails').factory('Search', ['railsResourceFactory', function (railsResourceFactory) {
  var resource = railsResourceFactory({
      url: '/api/search',
      name: 'search'
  });

  return resource;
}]);
