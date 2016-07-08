angular.module('portfolus').controller 'DetailOrderProjectCtrl', [
  '$scope'
  'OrderProject'
  '$parse'
  '$state'
  '$stateParams'
  '$mdDialog'
  '$mdMedia'
  '$mdToast'
  'Category'
  'OrderExecuterRequest'
  '$filter'
  ($scope, OrderProject, $parse, $state, $stateParams, $mdDialog, $mdMedia, $mdToast, Category, OrderExecuterRequest, $filter) ->
    # объект для формы
    # загрузка заказываемых текущим пользователем проектов

    load = ->
      OrderProject.get($stateParams.orderProjectId).then (result) ->
        $scope.orderProject = result
        $scope.userOrderExecuterRequest = $filter('filter')(result.orderExecuterRequests, { executerId: $scope.authUser.id }, true)[0]

    resetValidation = (form) ->
      $scope[form].$setPristine()
      $scope[form].$setValidity()
      $scope[form].$setUntouched()
      $scope[form].$error = {}

    $scope.orderProject = {}
    $scope.technology = {}
    $scope.orderProject.tags = []
    $scope.orderProject.technologies = []
    $scope.categories = []
    $scope.orderExecuterRequests = []
    $scope.userOrderExecuterRequest = {}
    load()

    $scope.createOrderExecuterRequest = (ev) ->
      useFullScreen = ($mdMedia('sm') or $mdMedia('xs')) and $scope.customFullscreen
      $mdDialog.show(
        templateUrl: 'orderExecuterRequest/tmpl/_new.html'
        controller: ($scope, OrderExecuterRequest, $parse, $mdDialog, orderProjectId, userId) ->
          # объект для формы
          $scope.orderExecuterRequest =
            orderProjectId: orderProjectId
            executerId: userId
            byCustomer: false
          # создать объект

          $scope.createOrderExecuterRequest = ->
            orderExecuterRequest = new OrderExecuterRequest($scope.orderExecuterRequest)
            orderExecuterRequest.create().then ((result) ->
              $scope.hide()
              load()
            ), (errors) ->
              `var errors`
              errors = errors.data
              angular.forEach errors, (error, field) ->
                $scope.OrderExecuterRequest.$setValidity field, false, $scope.email
                serverMessage = $parse('OrderExecuterRequest.' + field + '.$error.serverMessage')
                serverMessage.assign $scope, error.join(', ')

          $scope.hide = ->
            $mdDialog.hide()

        parent: angular.element(document.body)
        targetEvent: ev
        locals:
          orderProjectId: $scope.orderProject.id
          userId: $scope.authUser.id
        clickOutsideToClose: true
        fullscreen: useFullScreen).then ->
      $scope.$watch (->
        $mdMedia('xs') or $mdMedia('sm')
      ), (wantsFullScreen) ->
        $scope.customFullscreen = wantsFullScreen

    $scope.deleteOrderExecuterRequest = (ev) ->
      confirm = $mdDialog.confirm().title('Отменить предложение?').ariaLabel('Отмена предложения.').targetEvent(ev).ok('Да').cancel('Нет')
      $mdDialog.show(confirm).then ->
        new OrderExecuterRequest($scope.userOrderExecuterRequest).delete().then (result) ->
          $mdToast.show $mdToast.simple().textContent('Отменено.')
          load()

    # обновить объект

    $scope.updateOrderProject = ->
      orderProject = new OrderProject($scope.orderProject)
      orderProject.update().then ((result) ->
        $state.go 'orderProjects'
      ), (errors) ->
        `var errors`
        errors = errors.data
        angular.forEach errors, (error, field) ->
          $scope.OrderProject.$setValidity field, false, $scope.email
          serverMessage = $parse('OrderProject.' + field + '.$error.serverMessage')
          serverMessage.assign $scope, error.join(', ')

    # удаление

    $scope.delete = (ev) ->
      confirm = $mdDialog.confirm().title('Удалить?').ariaLabel('Удаление записи.').targetEvent(ev).ok('Да').cancel('Нет')
      $mdDialog.show(confirm).then ->
        $scope.orderProject.delete().then (result) ->
          $mdToast.show $mdToast.simple().textContent('Удалено.')
          $state.go 'orderProjects'

    $scope.chooseExecuter = (ev, request) ->
      confirm = $mdDialog.confirm().title('Выбрать исполнителем?').ariaLabel('Выбор исполнителя.').content('Сделанный выбор отменить нельзя.').targetEvent(ev).ok('Да').cancel('Нет')
      $mdDialog.show(confirm).then ->
        # подтверждаем запрос
        request.confirmed = true
        new OrderExecuterRequest(request).update().then (requestResult) ->
          # устанавливаем исполнителя
          $scope.orderProject.executerId = requestResult.executerId
          $scope.orderProject.update().then (orderProjectResult) ->
            $mdToast.show $mdToast.simple().textContent('Исполнитель выбран.')
            load()

    Category.query().then (result) ->
      $scope.categories = result
]
