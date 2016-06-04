angular.module('rails').factory('Project', ['railsResourceFactory', function (railsResourceFactory) {
    var resource = railsResourceFactory({
        url: '/api/projects',
        name: 'project'
    });

    resource.getDetail = function (params) {
      // формируем GET запрос
      var query = [];
      angular.forEach(params, function(el, key) { query['project['+key+']'] = el});

      return resource.$get(resource.$url('get_detail'),
        query).then(function (result) {
         return result;
      });
    };

    return resource;
}]);
