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
      template: '<span ui-view flex></span>'
    })
    .state('onlyguest', {
      abstract: true,
      parent: 'getuser',
      template: '<span ui-view flex></span>',
      onEnter: function ($rootScope, $state) {
        if ($rootScope.signedIn){
          $state.go('home');
        }
      }
    })
    .state('onlyusers', {
      abstract: true,
      parent: 'getuser',
      template: '<span ui-view flex></span>',
      onEnter: function ($rootScope, $state) {
        if (!$rootScope.signedIn){
          $state.go('home');
        }
      }
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
      title: 'пользователь',
      sideNav: true,
      url: '/{id:int}',
      templateUrl: 'user/_user.html',
      controller: 'UserCtrl',
      parent: 'onlyusers'
    })
    .state('auth', {
      title: 'авторизация',
      url: '/auth',
      templateUrl: 'auth/_auth.html',
      controller: 'AuthCtrl',
      parent: 'onlyguest'
    })
    .state('register', {
      title: 'присоединиться и создать электроное портфолио',
      url: '/register',
      templateUrl: 'auth/_register.html',
      controller: 'AuthCtrl',
      parent: 'onlyguest'
    })
    .state('projects', {
      title: 'портфолио пользователя',
      url: '/projects',
      templateUrl: 'project/_list.html',
      controller: 'ProjectCtrl',
      parent: 'onlyusers'
    })
    .state('project_new', {
      title: 'портфолио пользователя',
      url: '/projects/new',
      templateUrl: 'project/_new.html',
      controller: 'ProjectCtrl',
      parent: 'onlyusers'
    });

  $urlRouterProvider.otherwise('home');
})
.run(function($rootScope, $state, Auth) {
    $rootScope.$on('$stateChangeStart', function (event, toState, toParams, fromState, fromParams) {
      $rootScope.sideNav = !!toState.sideNav;
      $rootScope.title = toState.title ? ' - ' + toState.title : '';
    });
});
