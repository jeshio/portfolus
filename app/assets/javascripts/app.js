angular.module('portfolus', ['ui.router', 'templates', 'ngMaterial', 'ngAnimate', 'ngMessages', 'Devise', 'ng-rails-csrf', 'rails', 'isolateForm' ])
.config(['$mdThemingProvider', function($mdThemingProvider) {
  // расширение стандартной палитры
  var colorMap = $mdThemingProvider.extendPalette('blue', {
    '500': '01579b'
  });
  // регистрация новой палитры цветов
  $mdThemingProvider.definePalette('myColors', colorMap);

  $mdThemingProvider.theme('default')
    .primaryPalette('myColors');
}])
.config(['$mdIconProvider', function($mdIconProvider) {
  $mdIconProvider.fontSet('md', 'material-icons');
}])
.directive('activeLink', ['$location', function (location) {
  return {
    restrict: 'A',
    link: function(scope, element, attrs, controller) {
      var clazz = attrs.activeLink;
      var path = attrs.href||attrs.ngHref;
      scope.location = location;
      scope.$watch('location.path()', function () {
        if (path === location.url()) {
          element.addClass(clazz);
        } else {
          element.removeClass(clazz);
        }
      });
    }
  };
}]);
