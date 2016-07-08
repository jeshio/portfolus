angular.module('rails').factory 'ProjectConfirm', [
  'railsResourceFactory'
  (railsResourceFactory) ->
    resource = railsResourceFactory(
      url: '/api/project_confirms'
      name: 'projectConfirm')
    # позволяет передать параметры исполнителя, по которым уже на сервере будет найдено или создано подтверждение

    resource.createWithProjectAndUser = (projectId, executerId, confirmerId, comment) ->
      resource.$post(resource.$url('create_with_project_and_user'),
        projectId: projectId
        executerId: executerId
        confirmerId: confirmerId
        comment: comment).then (result) ->
        result

    # позволяет передать параметры, по которым уже на сервере будет найдена и подтверждена нужная связь

    resource.searchWithProjectAndUser = (projectId, executerId, confirmerId) ->
      resource.$post(resource.$url('search_with_project_and_user'),
        projectId: projectId
        executerId: executerId
        confirmerId: confirmerId).then (result) ->
        result

    resource
]
