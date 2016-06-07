angular.module('portfolus')
.controller('UserOrganizationCtrl',['$scope', 'UserOrganization', 'Organization', 'User', '$parse', '$mdDialog', '$mdMedia', '$mdToast',
function($scope, UserOrganization, Organization, User, $parse, $mdDialog, $mdMedia, $mdToast){
  $scope.userOrganizations = [];
  $scope.availableOrganizations = [];

  loadUserOrganizations();

  $scope.delete = function (userOrganization, ev) {
    // Appending dialog to document.body to cover sidenav in docs app
    var confirm = $mdDialog.confirm()
          .title('Выйти из организации?')
          .ariaLabel('Выход из организации')
          .targetEvent(ev)
          .ok('Да')
          .cancel('Нет');
    $mdDialog.show(confirm).then(function() {
      new UserOrganization(userOrganization).delete().then(function (result) {
        $mdToast.show($mdToast.simple().textContent('Вы вышли из организации.'));
        loadUserOrganizations();
      });
    });
  }

  function loadUserOrganizations() {
    User.get($scope.authUser.id).then(function (result) {
      result.userOrganizations().then(function (userOrganizations) {
        $scope.userOrganizations = userOrganizations;
      });
    });

    Organization.available().then(function (result) {
      $scope.availableOrganizations = result;
    });
  };

}]);
