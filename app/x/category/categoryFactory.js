angular.module('rails').factory('Category', ['railsResourceFactory', function (railsResourceFactory) {
    var resource = railsResourceFactory({
        url: '/api/categories',
        name: 'category'
    });

    return resource;
}]);
