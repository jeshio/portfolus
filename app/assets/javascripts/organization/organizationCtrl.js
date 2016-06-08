angular.module('portfolus')
.controller('OrganizationCtrl',['$scope', 'Organization', 'domenFromUrlFilter', '$parse', '$state',
function($scope, Organization, domenFromUrlFilter, $parse, $state){
  $scope.adminOrganizations = [];
  $scope.organization = {};
  writesDomen();

  // администрируемые организации
  Organization.whereYouAdmin().then(function (result) {
    $scope.adminOrganizations = result;
  });

  $scope.writesDomen = function () {
    writesDomen();
  }

  $scope.addOrganization = function () {
    var organization = new Organization($scope.organization);
    organization.create().then(function (result) {
      $state.go('organizationSettings');
    }, function (errors) {
      console.log(errors);
      var errors = errors.data;

      angular.forEach(errors, function (error, field) {
          $scope.Organization.$setValidity(field, false, $scope.email);
          var serverMessage = $parse('Organization.'+field+'.$error.serverMessage');
          serverMessage.assign($scope, error.join(', '));
      });
    });
  }

  function writesDomen() {
    // автоматическая конвертация URL в домен
    $scope.organization.domen = domenFromUrlFilter($scope.organization.url);
  }

}]);
