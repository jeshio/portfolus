angular.module('rails').factory('<%= file_name.camelize %>', ['railsResourceFactory', function (railsResourceFactory) {
    var resource = railsResourceFactory({
        url: '/api/<%= file_name_u.pluralize(2) %>',
        name: '<%= file_name %>'
    });

    return resource;
}]);
