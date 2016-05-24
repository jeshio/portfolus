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
.run(['$templateCache', '$http', function ($templateCache, $http) {
  $http.get('helpers/_errorMessages.html')
  .then(function(response) {
    $templateCache.put('error-messages', response.data);
  })
}])
.run(['$rootScope', 'Auth', '$state', function ($rootScope, Auth, $state) {
  $rootScope.$on('$stateChangeStart', function(event, toState) {

  })
}]);
