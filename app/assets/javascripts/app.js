angular.module('portfolus', ['ui.router', 'templates', 'ngMaterial', 'ngAnimate', 'Devise'])
.config([
'$stateProvider',
'$urlRouterProvider',
function($stateProvider, $urlRouterProvider) {

  $stateProvider
    .state('home', {
      title: 'электроное портфолио',
      sideNav: true,
      url: '/home',
      templateUrl: 'home/_home.html',
      controller: 'HomeCtrl'
    })
    .state('auth', {
      title: 'авторизация',
      url: '/auth',
      templateUrl: 'auth/_auth.html',
      controller: 'AuthCtrl'
    })
    .state('register', {
      title: 'присоединиться и создать электроное портфолио',
      url: '/register',
      templateUrl: 'auth/_register.html',
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
})
.run(['$rootScope', function($rootScope) {
    $rootScope.$on('$stateChangeStart', function (event, toState, toParams, fromState, fromParams) {
      $rootScope.sideNav = !!toState.sideNav;
      $rootScope.title = toState.title ? ' - ' + toState.title : '';
    });
}]);
