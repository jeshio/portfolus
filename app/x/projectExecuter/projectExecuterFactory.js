angular.module('rails').factory('ProjectExecuter', ['railsResourceFactory', function (railsResourceFactory) {
    var resource = railsResourceFactory({
        url: '/api/project_executers',
        name: 'projectExecuter'
    });

    resource.getWithConfirms = function (params) {
      // формируем GET запрос
      var query = [];
      angular.forEach(params, function(el, key) { query['project_executer['+key+']'] = el});

      return resource.$get(resource.$url('get_with_confirms'),
        query).then(function (result) {
         return result;
      });
    };

    return resource;
}]);
