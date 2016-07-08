angular.module('portfolus')
.controller('EmailCtrl',['$scope', 'Email', '$parse', '$mdDialog', '$mdMedia', '$mdToast', 'User',
function($scope, Email, $parse, $mdDialog, $mdMedia, $mdToast, User){
  $scope.emails = [];
  $scope.email = {};

  loadEmails();

  $scope.addEmail = function () {
    new Email({email: { email: $scope.email.email}}).create().then(function (data) {
      $mdToast.show($mdToast.simple().textContent('Email добавлен!'));
      loadEmails();
      $scope.email = {};
    }, function (errors) {
      var errors = errors.data;

      angular.forEach(errors, function (error, field) {
          $scope.Email.$setValidity(field, false, $scope.email);
          var serverMessage = $parse('Email.'+field+'.$error.serverMessage');
          serverMessage.assign($scope, error.join(', '));
      });
    });
  }

  $scope.delete = function (email, ev) {
    // Appending dialog to document.body to cover sidenav in docs app
    var confirm = $mdDialog.confirm()
          .title('Удалить почту из списка?')
          .ariaLabel('Удаление почты')
          .targetEvent(ev)
          .ok('Да')
          .cancel('Нет');
    $mdDialog.show(confirm).then(function() {
      email.delete().then(function (result) {
        loadEmails();
        $mdToast.show($mdToast.simple().textContent('Email удалён из сервиса!'));
      });
    });
  }

  function loadEmails() {
    User.get($scope.authUser.id).then(function (result) {
      result.emails().then(function (emails) {
        $scope.emails = emails;
      });
    });
  }
}]);
