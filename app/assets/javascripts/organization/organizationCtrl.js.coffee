angular.module('portfolus').controller 'OrganizationCtrl', [
  '$scope'
  'Organization'
  'domenFromUrlFilter'
  '$parse'
  '$state'
  ($scope, Organization, domenFromUrlFilter, $parse, $state) ->

    writesDomen = ->
      # автоматическая конвертация URL в домен
      $scope.organization.domen = domenFromUrlFilter($scope.organization.url)

    $scope.adminOrganizations = []
    $scope.organization = {}
    writesDomen()
    # администрируемые организации
    Organization.whereYouAdmin().then (result) ->
      $scope.adminOrganizations = result

    $scope.writesDomen = ->
      writesDomen()

    $scope.addOrganization = ->
      organization = new Organization($scope.organization)
      organization.create().then ((result) ->
        $state.go 'organizationSettings'
      ), (errors) ->
        `var errors`
        errors = errors.data
        angular.forEach errors, (error, field) ->
          $scope.Organization.$setValidity field, false, $scope.email
          serverMessage = $parse('Organization.' + field + '.$error.serverMessage')
          serverMessage.assign $scope, error.join(', ')
]
