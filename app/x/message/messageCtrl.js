angular.module('portfolus')
.controller('MessageCtrl',['$scope', 'Message', '$mdDialog', '$mdMedia', '$mdToast', '$stateParams', '$state',
function($scope, Message, $mdDialog, $mdMedia, $mdToast, $stateParams, $state){
  // список
  $scope.dialogs = [];

  loadDialogs();

  $scope.openDialog = function (msg) {
    if (msg.fromId == $scope.authUser.id) {
      $state.go('dialog', {second:msg.toId});
    }
    else
    {
      $state.go('dialog', {second:msg.fromId});
    }
  }

  // запрос списка
  function loadDialogs() {
    Message.dialogs().then(function (dialogs) {
      console.log(dialogs);
      $scope.dialogs = dialogs;
    }, function (errors) {
      console.log(errors);
    })
  };
}]);
