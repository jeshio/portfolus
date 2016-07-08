angular.module('rails').factory('Email', ['railsResourceFactory', function (railsResourceFactory) {
    var resource = railsResourceFactory({
        url: '/api/emails',
        name: 'email'
    });

    return resource;
}]);
