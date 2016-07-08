angular.module('portfolus').controller 'CreateOrderProjectCtrl', [
  '$scope'
  'OrderProject'
  '$parse'
  'Category'
  '$state'
  ($scope, OrderProject, $parse, Category, $state) ->
    # объект для формы

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
    # создать объект

    $scope.createOrderProject = ->
      orderProject = new OrderProject($scope.orderProject)
      orderProject.create().then ((result) ->
        $state.go 'orderProjectDetail', orderProjectId: result.id
      ), (errors) ->
        `var errors`
        console.log errors
        errors = errors.data
        angular.forEach errors, (error, field) ->
          $scope.OrderProject.$setValidity field, false, $scope.email
          serverMessage = $parse('OrderProject.' + field + '.$error.serverMessage')
          serverMessage.assign $scope, error.join(', ')

    $scope.addTehnology = ->
      resetValidation 'Technology'
      $scope.orderProject.technologies.push angular.copy($scope.technology)
      $scope.technology = {}

    $scope.deleteTech = (technology) ->
      $scope.project.technologies.splice $scope.project.technologies.indexOf(technology), 1

    Category.query().then (result) ->
      $scope.categories = result
]
