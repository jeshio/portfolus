angular.module('portfolus', ['ui.router', 'templates', 'ngMaterial'])
.config([
'$stateProvider',
'$urlRouterProvider',
function($stateProvider, $urlRouterProvider) {

  $stateProvider
    .state('home', {
      url: '/home',
      templateUrl: 'home/_home.html',
      controller: 'MainCtrl'
    });

  $urlRouterProvider.otherwise('home');
}])
.config(function($mdThemingProvider) {
  // Extend the red theme with a few different colors
  var colorMap = $mdThemingProvider.extendPalette('blue', {
    '500': '01579b'
  });
  // Register the new color palette map with the name <code>neonRed</code>
  $mdThemingProvider.definePalette('myColors', colorMap);

  $mdThemingProvider.theme('default')
    .primaryPalette('myColors');
})
.config(function($mdIconProvider) {
  $mdIconProvider.fontSet('md', 'material-icons');
});
