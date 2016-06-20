angular.module('portfolus')
.controller('PortfolioCtrl',['$scope', 'User', '$stateParams',
function($scope, User, $stateParams){
  $scope.projects = [];
  $scope.organizations = [];
  $scope.userOrganizations = [];
  $scope.userId = $stateParams.id;

  User.getAllProjects($stateParams.id).then(function (result) {
    $scope.projects = result;
  }, function (error) {
    console.log(error);
  });

  User.get($stateParams.id).then(function (user) {
    user.userOrganizations().then(function (userOrganizations) {
      $scope.userOrganizations = userOrganizations;
    });
    user.organizations().then(function (organizations) {
      $scope.organizations = organizations;
    });
  });

}]);
