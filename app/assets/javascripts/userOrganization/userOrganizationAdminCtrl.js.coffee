angular.module('portfolus').controller 'UserOrganizationAdminCtrl', [
  '$scope'
  'UserOrganization'
  'Organization'
  'User'
  '$parse'
  '$mdDialog'
  '$mdMedia'
  '$mdToast'
  '$stateParams'
  ($scope, UserOrganization, Organization, User, $parse, $mdDialog, $mdMedia, $mdToast, $stateParams) ->

    loadUserOrganizations = ->
      Organization.get($stateParams.id).then (result) ->
        $scope.organizaton = result
        console.log result

    $scope.organizaton = {}
    $scope.organizaton.userOrganizations = []
    loadUserOrganizations()

    $scope.delete = (userOrganization, ev) ->
      # Appending dialog to document.body to cover sidenav in docs app
      confirm = $mdDialog.confirm().title('Исключить из организации?').ariaLabel('Исключить из организации').targetEvent(ev).ok('Да').cancel('Нет')
      $mdDialog.show(confirm).then ->
        new UserOrganization(userOrganization).delete().then (result) ->
          loadUserOrganizations()
]
