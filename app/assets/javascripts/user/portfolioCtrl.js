angular.module('portfolus')
.controller('PortfolioCtrl',['$scope', 'User', '$stateParams',
function($scope, User, $stateParams){
  $scope.projects = [];
  $scope.organizations = [];
  $scope.userOrganizations = [];
  $scope.userId = $stateParams.id;
  $scope.year = 2016;
  $scope.years = [];

  $scope.dateMonthCompare = function (year, month, startTime, finishTime) {
    if (startTime == null) {
      return false;
    }
    var compare = new Date(year, month),
      startCompare = new Date(year, month+1, 0),
      startDate = new Date(startTime),
      finishDate = new Date(finishTime);

    if (finishTime == null) {
      finishDate = new Date();
    }

    return startCompare >= startDate && finishDate >= compare;
  }

  User.getAllProjects($stateParams.id).then(function (result) {
    $scope.projects = result;

    // получаем все года работы над проектами для диаграммы Ганта
    angular.forEach(result, function (project) {
      if (project.startDate)
        $scope.years.push(new Date(project.startDate).getFullYear());
      if (project.finishDate)
        $scope.years.push(new Date(project.finishDate).getFullYear());
      if (project.devFinishDate)
        $scope.years.push(new Date(project.devFinishDate).getFullYear());
    });
    // уникальные значения
    $scope.years = $scope.years.filter(function(item, i, ar){ return ar.indexOf(item) === i; })
  });

  User.get($stateParams.id).then(function (user) {
    user.userOrganizations().then(function (userOrganizations) {
      $scope.userOrganizations = userOrganizations;
    });
    user.organizations().then(function (organizations) {
      $scope.organizations = organizations;
    });
  });

  $scope.slickConfig = {
      enabled: true,
      centerMode: true,
      adaptiveHeight: true,
      arrows: false,
      autoplay: true,
      draggable: false,
      autoplaySpeed: 3000,
      method: {},
      responsive: [
        {
          breakpoint: 768,
          settings: {
            arrows: false,
            centerMode: true,
            centerPadding: '40px',
            slidesToShow: 3
          }
        },
        {
          breakpoint: 480,
          settings: {
            arrows: false,
            centerMode: true,
            centerPadding: '40px',
            slidesToShow: 1
          }
        }
      ]
    };

}]);
