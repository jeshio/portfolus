angular.module('rails').factory('<%= file_name.capitalize %>', ['railsResourceFactory', function (railsResourceFactory) {
    var resource = railsResourceFactory({
        url: '/api/<%= file_name.pluralize(2) %>',
        name: '<%= file_name %>'
    });

    return resource;
}]);
