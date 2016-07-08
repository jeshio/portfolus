angular.module('rails').factory('City', ['railsResourceFactory', function (railsResourceFactory) {
    return railsResourceFactory({
        url: '/api/cities',
        name: 'city'
    });
}]);
