angular.module('rails').factory('OrderExecuterRequest', ['railsResourceFactory', function (railsResourceFactory) {
    var resource = railsResourceFactory({
        url: '/api/order_executer_requests',
        name: 'orderExecuterRequest'
    });

    return resource;
}]);
