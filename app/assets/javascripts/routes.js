angular.module('portfolus')
.config(['$stateProvider', '$urlRouterProvider', '$locationProvider', '$httpProvider',
function($stateProvider, $urlRouterProvider, $locationProvider, $httpProvider) {
  $locationProvider.html5Mode(true);
  $stateProvider
    .state('getuser', {
      abstract: true,
      resolve: {
        authUser: function (Auth) {
          return Auth.currentUser().then(function (user) {
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
      title: 'Электроное портфолио',
      url: '/home',
      templateUrl: 'home/_home.html',
      controller: 'HomeCtrl',
      parent: 'getuser'
    })
    // настройки
    .state('settings', {
      title: 'Настройки',
      url: '/settings',
      templateUrl: 'user/_settings.html',
      controller: 'PortfolioCtrl',
      parent: 'onlyusers'
    })
    // просмотр порфтолио
    .state('user', {
      title: 'Пользователь',
      url: '/{id:int}',
      templateUrl: 'user/_portfolio.html',
      controller: 'PortfolioCtrl',
      parent: 'getuser'
    })
    .state('auth', {
      title: 'Авторизация',
      url: '/auth',
      templateUrl: 'auth/_auth.html',
      controller: 'AuthCtrl',
      parent: 'onlyguest'
    })
    .state('register', {
      title: 'Создать электроное портфолио',
      url: '/register',
      templateUrl: 'auth/_register.html',
      controller: 'AuthCtrl',
      parent: 'onlyguest'
    })
    .state('projects', {
      title: 'Портфолио пользователя',
      url: '/projects',
      templateUrl: 'project/_list.html',
      controller: 'ProjectCtrl',
      parent: 'onlyusers'
    })
    .state('project_new', {
      title: 'Добавить проект',
      url: '/projects/new',
      templateUrl: 'project/_new.html',
      controller: 'ProjectCtrl',
      parent: 'onlyusers'
    })
    .state('search', {
      parent: 'getuser',
      title: 'Поиск портфолио',
      sideNav: true,
      url: '/search',
      reloadOnSearch : false,
      disablePadding: true,
      resolve: {
        cities: function (City) {
          return City.query().then(function (result) {
            return result;
          });
        }
      },
      views: {
        '@': { templateUrl: 'search/_list.html', controller: 'SearchCtrl' },
        'sideNav@': { templateUrl: 'search/_filters.html', controller: 'SearchFilterCtrl' },
      }
    });

  $urlRouterProvider.otherwise('home');
}])
.run(['$rootScope', '$state', 'Auth', function($rootScope, $state, Auth) {
    $rootScope.$on('$stateChangeStart', function (event, toState, toParams, fromState, fromParams) {
      $rootScope.sideNav = !!toState.sideNav; // показать сайд бар справа
      $rootScope.title = toState.title ? toState.title : ''; // title страницы
      $rootScope.disablePadding = !!toState.disablePadding; // отключить паддинг в мейне
    });
    $rootScope.$on('devise:login', function(event, currentUser) {
      $rootScope.signedIn = Auth.isAuthenticated();
      $rootScope.logout = Auth.logout;
    });
}]);
