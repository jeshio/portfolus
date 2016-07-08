angular.module('portfolus').controller 'UserOrganizationCtrl', [
  '$scope'
  'UserOrganization'
  'Organization'
  'User'
  '$parse'
  '$mdDialog'
  '$mdMedia'
  '$mdToast'
  '$state'
  ($scope, UserOrganization, Organization, User, $parse, $mdDialog, $mdMedia, $mdToast, $state) ->

    loadUserOrganizations = ->
      User.get($scope.authUser.id).then (result) ->
        result.userOrganizations().then (userOrganizations) ->
          $scope.userOrganizations = userOrganizations
      Organization.available().then (result) ->
        $scope.availableOrganizations = result

    $scope.userOrganizations = []
    $scope.availableOrganizations = []
    loadUserOrganizations()

    $scope.delete = (userOrganization, ev) ->
      # Appending dialog to document.body to cover sidenav in docs app
      confirm = $mdDialog.confirm().title('Выйти из организации?').ariaLabel('Выход из организации').targetEvent(ev).ok('Да').cancel('Нет')
      $mdDialog.show(confirm).then ->
        new UserOrganization(userOrganization).delete().then (result) ->
          $mdToast.show $mdToast.simple().textContent('Вы вышли из организации.')
          loadUserOrganizations()
]
