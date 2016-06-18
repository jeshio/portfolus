angular.module('rails').factory('User', ['railsResourceFactory', '$http', function (railsResourceFactory, $http) {
    var resource = railsResourceFactory({
        url: '/api/users',
        name: 'user'
    });
    resource.getAllProjects = function (user_id) {
      return resource.$get(resource.$url(user_id + '/all_projects'));
    };

    resource.prototype.userOrganizations = function () {
      return resource.$get(resource.$url(this.id + '/user_organizations'));
    };

    resource.prototype.emails = function () {
      return resource.$get(resource.$url(this.id + '/emails'));
    };

    resource.prototype.executerRequests = function () {
      return resource.$get(resource.$url(this.id + '/executer_requests'));
    }

    resource.prototype.orderProjects = function () {
      return resource.$get(resource.$url(this.id + '/order_projects'));
    };

    resource.prototype.toExecuterRequests = function () {
      return resource.$get(resource.$url(this.id + '/to_executer_requests'));
    }

    resource.prototype.orderExecuterRequests = function () {
      return resource.$get(resource.$url(this.id + '/order_executer_requests'));
    }

    return resource;
}]);
