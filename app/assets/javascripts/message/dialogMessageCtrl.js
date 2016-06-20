angular.module('portfolus')
.controller('DialogMessageCtrl',['$scope', 'Message', '$mdDialog', '$mdMedia', '$mdToast', '$stateParams', 'User',
function($scope, Message, $mdDialog, $mdMedia, $mdToast, $stateParams, User){
  // список
  $scope.messages = [];
  $scope.message = {fromId: $scope.authUser.id, toId: $stateParams.second};
  $scope.second = {};

  loadMessages();

  $scope.sendMessage = function () {
    var message = new Message($scope.message);
    message.create().then(function (result) {
      $scope.message = {fromId: $scope.authUser.id, toId: $stateParams.second};
      loadMessages();
    }, function (errors) {
      var errors = errors.data;

      angular.forEach(errors, function (error, field) {
          $scope.Message.$setValidity(field, false, $scope.email);
          var serverMessage = $parse('Message.'+field+'.$error.serverMessage');
          serverMessage.assign($scope, error.join(', '));
      });
    });
  }

  // запрос списка
  function loadMessages() {
    Message.dialog($scope.authUser.id, $stateParams.second).then(function (result) {
      console.log(result);
      $scope.messages = result;
    },function (errors) {
      console.log(errors);
    });
  };
  // запрос собеседника
  User.get($stateParams.second).then(function (data) {
    $scope.second = data;
  });
}]);
