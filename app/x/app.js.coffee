angular.module('portfolus', [
  'ui.router'
  'templates'
  'ngMaterial'
  'ngAnimate'
  'ngMessages'
  'Devise'
  'ng-rails-csrf'
  'rails'
  'isolateForm'
  'angular-loading-bar'
  'slickCarousel'
]).config([
  '$mdThemingProvider'
  ($mdThemingProvider) ->
    # расширение стандартной палитры
    colorMap = $mdThemingProvider.extendPalette('blue', '500': '01579b')
    # регистрация новой палитры цветов
    $mdThemingProvider.definePalette 'myColors', colorMap
    $mdThemingProvider.theme('default').primaryPalette 'myColors'
]).config([
  '$mdIconProvider'
  ($mdIconProvider) ->
    $mdIconProvider.fontSet 'md', 'material-icons'
]).directive('activeLink', [
  '$location'
  (location) ->
    {
      restrict: 'A'
      link: (scope, element, attrs, controller) ->
        clazz = attrs.activeLink
        path = attrs.href or attrs.ngHref
        scope.location = location
        scope.$watch 'location.path()', ->
          if path == location.path()
            element.addClass clazz
          else
            element.removeClass clazz
    }
]).directive 'activeChip', ->
  {
    restrict: 'EA'
    link: (scope, elem, attrs) ->
      scope.$watch attrs.activeChip, (value) ->
        if value
          myChip = elem.parent().parent()
          myChip.addClass '_active'
  }
