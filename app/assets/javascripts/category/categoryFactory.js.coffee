angular.module('rails').factory 'Category', [
  'railsResourceFactory'
  (railsResourceFactory) ->
    resource = railsResourceFactory(
      url: '/api/categories'
      name: 'category')
    resource
]
