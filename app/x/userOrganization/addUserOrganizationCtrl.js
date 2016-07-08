angular.module('portfolus')
.controller('AddUserOrganizationCtrl',['$scope', 'UserOrganization', 'Organization', '$stateParams', '$state',
function($scope, UserOrganization, Organization, $stateParams, $state){
  $scope.userOrganization = { organizationId: $stateParams.id };
  $scope.organization = {};

  $scope.addUserOrganization = function () {
    new UserOrganization($scope.userOrganization).create().then(function (result) {
      $state.go('organizationSettings');
    }, function (errors) {
      var errors = errors.data;

      angular.forEach(errors, function (error, field) {
          $scope.UserOrganization.$setValidity(field, false, $scope.email);
          var serverMessage = $parse('UserOrganization.'+field+'.$error.serverMessage');
          serverMessage.assign($scope, error.join(', '));
      });
    })
  }

  UserOrganization.query().then(function (result) {
    $scope.userOrganizations = result;
  });

  Organization.get($stateParams.id).then(function (result) {
    $scope.organization = result;
  });
}]);
