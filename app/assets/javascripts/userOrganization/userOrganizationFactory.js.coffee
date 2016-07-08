angular.module('rails').factory 'UserOrganization', [
  'railsResourceFactory'
  (railsResourceFactory) ->
    resource = railsResourceFactory(
      url: '/api/user_organizations'
      name: 'userOrganization')
    resource
]
