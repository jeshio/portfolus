angular.module('rails').factory('User', ['railsResourceFactory', '$http', function (railsResourceFactory, $http) {
    var resource = railsResourceFactory({
        url: '/api/users',
        name: 'user'
    });
    resource.getAllProjects = function (user_id) {
      return resource.$get(resource.$url(user_id + '/all_projects')).then(function (projects) {
         return projects;
      });;
    };

    return resource;
}]);
