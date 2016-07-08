angular.module('rails').factory('Search', ['railsResourceFactory', function (railsResourceFactory) {
  var resource = railsResourceFactory({
      url: '/api/search',
      name: 'search'
  });

  resource.executers = function (params) {
    return resource.$get(resource.$url('executers'), params);
  }

  resource.projects = function (params) {
    return resource.$get(resource.$url('projects'), params);
  }

  resource.orders = function (params) {
    return resource.$get(resource.$url('orders'), params);
  }

  return resource;
}]);
