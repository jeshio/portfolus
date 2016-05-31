angular.module('rails').factory('ProjectExecuter', ['railsResourceFactory', function (railsResourceFactory) {
    var resource = railsResourceFactory({
        url: '/api/project_executers',
        name: 'projectExecuter'
    });

    return resource;
}]);
