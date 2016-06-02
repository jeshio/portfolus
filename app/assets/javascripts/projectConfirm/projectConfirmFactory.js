angular.module('rails').factory('ProjectConfirm', ['railsResourceFactory', function (railsResourceFactory) {
    var resource = railsResourceFactory({
        url: '/api/project_confirms',
        name: 'projectConfirm'
    });

    // позволяет передать параметры, по которым уже на сервере будет найдена и подтверждена нужная связь
    resource.createWithProjectAndUser = function (projectId, executerId, confirmerId, comment) {
      return resource.$post(resource.$url('create_with_project_and_user'),
        { projectId: projectId, executerId: executerId, confirmerId: confirmerId, comment: comment }).then(function (result) {
         return result;
      });
    };

    return resource;
}]);
