angular.module('rails').factory('OrderProject', ['railsResourceFactory', function (railsResourceFactory) {
    var resource = railsResourceFactory({
        url: '/api/order_projects',
        name: 'orderProject'
    });

    return resource;
}]);
