angular.module('portfolus')
.controller('UserOrganizationAdminCtrl',['$scope', 'UserOrganization', 'Organization', 'User', '$parse', '$mdDialog', '$mdMedia', '$mdToast', '$stateParams',
function($scope, UserOrganization, Organization, User, $parse, $mdDialog, $mdMedia, $mdToast, $stateParams){
  $scope.organizaton = {};
  $scope.organizaton.userOrganizations = [];

  loadUserOrganizations();

  $scope.delete = function (userOrganization, ev) {
    // Appending dialog to document.body to cover sidenav in docs app
    var confirm = $mdDialog.confirm()
          .title('Исключить из организации?')
          .ariaLabel('Исключить из организации')
          .targetEvent(ev)
          .ok('Да')
          .cancel('Нет');
    $mdDialog.show(confirm).then(function() {
      new UserOrganization(userOrganization).delete().then(function (result) {
        loadUserOrganizations();
      });
    });
  }

  function loadUserOrganizations() {
    Organization.get($stateParams.id).then(function (result) {
      $scope.organizaton = result;
      console.log(result);
    });
  };

}]);
