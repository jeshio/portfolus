angular.module('portfolus')
.config(
function($stateProvider, $urlRouterProvider, $locationProvider, $httpProvider) {
  $locationProvider.html5Mode(true);
  $stateProvider
    .state('getuser', {
      abstract: true,
      resolve: {
        authUser: function (Auth, $rootScope) {
          return Auth.currentUser().then(function (user) {
            $rootScope.signedIn = Auth.isAuthenticated();
            $rootScope.logout = Auth.logout;
            return user;
          }, function () {
            return;
          });
        }
      },
      template: '<ui-view/>'
    })
    .state('home', {
      title: 'электроное портфолио',
      sideNav: true,
      url: '/home',
      templateUrl: 'home/_home.html',
      controller: 'HomeCtrl',
      parent: 'getuser'
    })
    .state('user', {
      title: 'портфолио пользователя',
      sideNav: true,
      url: '/{id:int}',
      templateUrl: 'user/_user.html',
      controller: 'UserCtrl',
      parent: 'getuser'
    })
    .state('auth', {
      title: 'авторизация',
      url: '/auth',
      templateUrl: 'auth/_auth.html',
      controller: 'AuthCtrl',
      onlyGuest: true
    })
    .state('register', {
      title: 'присоединиться и создать электроное портфолио',
      url: '/register',
      templateUrl: 'auth/_register.html',
      controller: 'AuthCtrl',
      onlyGuest: true
    });

  $urlRouterProvider.otherwise('home');
})
.run(function($rootScope, $state, Auth) {
    $rootScope.$on('$stateChangeStart', function (event, toState, toParams, fromState, fromParams) {
      $rootScope.sideNav = !!toState.sideNav;
      $rootScope.title = toState.title ? ' - ' + toState.title : '';

      // только гости
      if (toState.onlyGuest) {
        Auth.currentUser().then(function (){
          $state.go('home');
        })
      }
    });
});