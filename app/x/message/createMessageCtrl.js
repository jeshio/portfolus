angular.module('portfolus')
.controller('CreateMessageCtrl',['$scope', 'Message', '$parse', '$state',
function($scope, Message, $parse, $state){
  // объект для формы
  $scope.message = {};

  // создать объект
  $scope.createMessage = function () {
    var message = new Message($scope.message);
    message.create().then(function (result) {
      $state.go('messages');
    }, function (errors) {
      var errors = errors.data;

      angular.forEach(errors, function (error, field) {
          $scope.Message.$setValidity(field, false, $scope.email);
          var serverMessage = $parse('Message.'+field+'.$error.serverMessage');
          serverMessage.assign($scope, error.join(', '));
      });
    });
  }
}]);
