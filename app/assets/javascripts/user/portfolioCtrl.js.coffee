angular.module('portfolus').controller 'PortfolioCtrl', [
  '$scope'
  'User'
  '$stateParams'
  ($scope, User, $stateParams) ->
    $scope.projects = []
    $scope.organizations = []
    $scope.userOrganizations = []
    $scope.user = {}
    $scope.year = 2016
    $scope.years = []

    $scope.dateMonthCompare = (year, month, startTime, finishTime) ->
      if !startTime?
        return false
      compare = new Date(year, month)
      startCompare = new Date(year, month + 1, 0)
      startDate = new Date(startTime)
      finishDate = new Date(finishTime)
      if !finishTime?
        finishDate = new Date
      startCompare >= startDate and finishDate >= compare

    User.getAllProjects($stateParams.id).then (result) ->
      $scope.projects = result
      # получаем все года работы над проектами для диаграммы Ганта
      angular.forEach result, (project) ->
        if project.startDate
          $scope.years.push new Date(project.startDate).getFullYear()
        if project.finishDate
          $scope.years.push new Date(project.finishDate).getFullYear()
        if project.devFinishDate
          $scope.years.push new Date(project.devFinishDate).getFullYear()
      # уникальные значения
      $scope.years = $scope.years.filter((item, i, ar) ->
        ar.indexOf(item) is i
      )
      $scope.year = $scope.years[0]
    User.get($stateParams.id).then (user) ->
      $scope.user = user
      user.userOrganizations().then (userOrganizations) ->
        $scope.userOrganizations = userOrganizations
      user.organizations().then (organizations) ->
        $scope.organizations = organizations
    $scope.slickConfig =
      enabled: true
      centerMode: true
      adaptiveHeight: true
      arrows: false
      autoplay: true
      draggable: false
      autoplaySpeed: 3000
      method: {}
      responsive: [
        {
          breakpoint: 768
          settings:
            arrows: false
            centerMode: true
            centerPadding: '40px'
            slidesToShow: 3
        }
        {
          breakpoint: 480
          settings:
            arrows: false
            centerMode: true
            centerPadding: '40px'
            slidesToShow: 1
        }
      ]
]
