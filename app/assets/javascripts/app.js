angular.module('portfolus', ['ui.router', 'templates', 'ngMaterial', 'ngAnimate'])
.config([
'$stateProvider',
'$urlRouterProvider',
function($stateProvider, $urlRouterProvider) {

  $stateProvider
    .state('home', {
      url: '/home',
      templateUrl: 'home/_home.html',
      controller: 'HomeCtrl'
    })
    .state('auth', {
      url: '/auth',
      templateUrl: 'auth/_auth.html',
      controller: 'AuthCtrl'
    });

  $urlRouterProvider.otherwise('home');
}])
.config(function($mdThemingProvider) {
  // расширение стандартной палитры
  var colorMap = $mdThemingProvider.extendPalette('blue', {
    '500': '01579b'
  });
  // регистрация новой палитры цветов
  $mdThemingProvider.definePalette('myColors', colorMap);

  $mdThemingProvider.theme('default')
    .primaryPalette('myColors');
})
.config(function($mdIconProvider) {
  $mdIconProvider.fontSet('md', 'material-icons');
});
