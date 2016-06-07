angular.module('rails').factory('UserOrganization', ['railsResourceFactory', function (railsResourceFactory) {
    var resource = railsResourceFactory({
        url: '/api/user_organizations',
        name: 'userOrganization'
    });

    return resource;
}]);
