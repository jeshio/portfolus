angular.module('rails').factory('Message', ['railsResourceFactory', function (railsResourceFactory) {
    var resource = railsResourceFactory({
        url: '/api/messages',
        name: 'message'
    });

    // диалог с двумя участниками
    resource.dialog = function (first, second) {
      return resource.$get(resource.$url(first+'/'+second));
    };

    resource.dialogs = function () {
      return resource.$get(resource.$url('dialogs'));
    }

    return resource;
}]);
