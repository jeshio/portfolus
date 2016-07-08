angular.module('rails').factory 'City', [
  'railsResourceFactory'
  (railsResourceFactory) ->
    railsResourceFactory
      url: '/api/cities'
      name: 'city'
]
