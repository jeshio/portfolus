angular.module('rails').factory('Organization', ['railsResourceFactory', function (railsResourceFactory) {
    var resource = railsResourceFactory({
        url: '/api/organizations',
        name: 'organization'
    });

    resource.whereYouAdmin = function () {
      return resource.$get(resource.$url('where_you_admin')).then(function (result) {
         return result;
      });
    };

    resource.available = function () {
      return resource.$get(resource.$url('available')).then(function (result) {
         return result;
      });
    };

    return resource;
}]);
