angular.module('portfolus').controller 'AddUserOrganizationCtrl', [
  '$scope'
  'UserOrganization'
  'Organization'
  '$stateParams'
  '$state'
  ($scope, UserOrganization, Organization, $stateParams, $state) ->
    $scope.userOrganization = organizationId: $stateParams.id
    $scope.organization = {}

    $scope.addUserOrganization = ->
      new UserOrganization($scope.userOrganization).create().then ((result) ->
        $state.go 'organizationSettings'
      ), (errors) ->
        `var errors`
        errors = errors.data
        angular.forEach errors, (error, field) ->
          $scope.UserOrganization.$setValidity field, false, $scope.email
          serverMessage = $parse('UserOrganization.' + field + '.$error.serverMessage')
          serverMessage.assign $scope, error.join(', ')

    UserOrganization.query().then (result) ->
      $scope.userOrganizations = result
    Organization.get($stateParams.id).then (result) ->
      $scope.organization = result
]
