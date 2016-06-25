angular.module('portfolus')
.controller('PortfolioCtrl',['$scope', 'User', '$stateParams',
function($scope, User, $stateParams){
  $scope.projects = [];
  $scope.organizations = [];
  $scope.userOrganizations = [];
  $scope.userId = $stateParams.id;
  $scope.year = 2016;

  $scope.dateMonthCompare = function (year, month, startTime, finishTime) {
    if (startTime == null) {
      return false;
    }
    var compare = new Date(year, month),
      startCompare = new Date(year, month+1, 0),
      startDate = new Date(startTime),
      finishDate = new Date(finishTime);

    return startCompare >= startDate && finishTime == null ||
      startCompare >= startDate && finishDate >= compare;
  }

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
