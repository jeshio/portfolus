angular.module('rails').factory 'Email', [
  'railsResourceFactory'
  (railsResourceFactory) ->
    resource = railsResourceFactory(
      url: '/api/emails'
      name: 'email')
    resource
]
