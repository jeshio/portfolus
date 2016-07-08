angular.module('portfolus').controller 'ProjectCtrl', [
  '$scope'
  'Project'
  'User'
  'Category'
  '$mdConstant'
  '$mdMedia'
  '$mdDialog'
  '$state'
  '$parse'
  'ProjectExecuter'
  '$mdToast'
  ($scope, Project, User, Category, $mdConstant, $mdMedia, $mdDialog, $state, $parse, ProjectExecuter, $mdToast) ->

    resetValidation = (form) ->
      $scope[form].$setPristine()
      $scope[form].$setValidity()
      $scope[form].$setUntouched()
      $scope[form].$error = {}

    $scope.project = {}
    $scope.technology = {}
    $scope.project.tags = []
    $scope.project.technologies = []
    $scope.project.partners = []
    $scope.confirmers = []
    # список подтвердивших
    $scope.projects = []
    $scope.categories = []

    User.getAllProjects($scope.authUser.id).then (result) ->
      $scope.projects = result
    Category.query().then (result) ->
      $scope.categories = result

    $scope.create = ->
      new Project($scope.project).create().then ((data) ->
        $state.go 'projects'
      ), (errors) ->
        angular.forEach errors.data.errors, (model, modelName) ->
          angular.forEach model, (error, field) ->
            modelNameUp = modelName.charAt(0).toUpperCase() + modelName.substr(1).toLowerCase()
            $scope[modelNameUp].$setValidity field, false, $scope.project
            serverMessage = $parse(modelNameUp + '.' + field + '.$error.serverMessage')
            serverMessage.assign $scope, error.join(', ')

    $scope.addTehnology = ->
      resetValidation 'Technology'
      $scope.project.technologies.push angular.copy($scope.technology)
      $scope.technology = {}

    $scope.deleteTech = (technology) ->
      $scope.project.technologies.splice $scope.project.technologies.indexOf(technology), 1

    $scope.showDetail = (ev, project) ->
      useFullScreen = ($mdMedia('sm') or $mdMedia('xs')) and $scope.customFullscreen
      $mdDialog.show(
        templateUrl: 'project/_dialog.html'
        controller: ($scope, $mdDialog, project, userId) ->
          $scope.project = project
          $scope.userId = userId

          $scope.hide = ->
            $mdDialog.hide()

        parent: angular.element(document.body)
        targetEvent: ev
        locals:
          project: project
          userId: $scope.authUser.id
        clickOutsideToClose: true
        fullscreen: useFullScreen).then ->
      $scope.$watch (->
        $mdMedia('xs') or $mdMedia('sm')
      ), (wantsFullScreen) ->
        $scope.customFullscreen = wantsFullScreen is true

    # сообщения об участии
    $scope.showExecuterRequests = (ev) ->
      useFullScreen = ($mdMedia('sm') or $mdMedia('xs')) and $scope.customFullscreen
      $mdDialog.show(
        templateUrl: 'projectExecuter/tmpl/_dialogExecuterRequests.html'
        controller: ($scope, $mdDialog, authUser) ->

          loadRequests = ->
            User.get(authUser.id).then (result) ->
              result.executerRequests().then (requests) ->
                $scope.projectExecuters = requests
              result.toExecuterRequests().then (requests) ->
                $scope.executerRequestedProjects = requests

          $scope.authUser = authUser
          $scope.projectExecuters = []
          $scope.executerRequestedProjects = []
          loadRequests()

          $scope.deleteExecuter = (executer) ->
            new ProjectExecuter(executer).delete().then ->
              $mdToast.show $mdToast.simple().textContent('Запрос отклонён.')
              loadRequests()

          # создатель проекта подтверждает участие пользователя

          $scope.acceptExecuter = (executer) ->
            executer.creater_confirmed = true
            new ProjectExecuter(executer).update().then ->
              $mdToast.show $mdToast.simple().textContent('Запрос об участии принят.')
              loadRequests()

          $scope.hide = ->
            $mdDialog.hide()

        parent: angular.element(document.body)
        targetEvent: ev
        locals: authUser: $scope.authUser
        clickOutsideToClose: true
        fullscreen: useFullScreen).then ->
      $scope.$watch (->
        $mdMedia('xs') or $mdMedia('sm')
      ), (wantsFullScreen) ->
        $scope.customFullscreen = wantsFullScreen == true
]
