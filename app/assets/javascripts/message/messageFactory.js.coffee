angular.module('rails').factory 'Message', [
  'railsResourceFactory'
  (railsResourceFactory) ->
    resource = railsResourceFactory(
      url: '/api/messages'
      name: 'message')
    # диалог с двумя участниками

    resource.dialog = (first, second) ->
      resource.$get resource.$url(first + '/' + second)

    resource.dialogs = ->
      resource.$get resource.$url('dialogs')

    resource
]
