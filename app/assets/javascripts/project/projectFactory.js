angular.module('rails').factory('Project', ['railsResourceFactory', function (railsResourceFactory) {
    var resource = railsResourceFactory({
        url: '/api/projects',
        name: 'project'
    });

    return resource;
}]);
