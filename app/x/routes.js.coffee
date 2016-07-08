angular.module('portfolus').config([
  '$stateProvider'
  '$urlRouterProvider'
  '$locationProvider'
  '$httpProvider'
  ($stateProvider, $urlRouterProvider, $locationProvider, $httpProvider) ->
    $locationProvider.html5Mode true

    $stateProvider.state('getuser',
      abstract: true
      resolve: authUser: (Auth) ->
        Auth.currentUser().then ((user) ->
          user
        ), ->
      template: '<span ui-view flex></span>')

      .state('onlyguest',
        abstract: true
        parent: 'getuser'
        template: '<span ui-view flex></span>'
        onEnter: ($rootScope, $state) ->
          if $rootScope.signedIn
            $state.go 'home'
      )

      .state('onlyusers',
        abstract: true
        parent: 'getuser'
        template: '<span ui-view flex></span>'
        onEnter: ($rootScope, $state) ->
          if !$rootScope.signedIn
            $state.go 'home'
      )

      .state('home',
      title: 'Электроное портфолио'
      url: '/home'
      templateUrl: 'home/_home.html'
      controller: 'HomeCtrl'
      parent: 'getuser')

      .state('mainSettings',
      title: 'Основные настройки'
      url: '/settings'
      sideNav: true
      parent: 'onlyusers'
      views:
        '@':
          templateUrl: 'user/tmpl/_settings.html'
          controller: 'UserCtrl'
        'sideNav@':
          templateUrl: 'user/tmpl/_sideNavSettings.html'
          controller: 'SideNavSettingsCtrl')

      .state('emailSettings',
      title: 'Список электронных почт'
      url: '/settings/emails'
      sideNav: true
      parent: 'onlyusers'
      views:
        '@':
          templateUrl: 'user/tmpl/_emailSettings.html'
          controller: 'EmailCtrl'
        'sideNav@':
          templateUrl: 'user/tmpl/_sideNavSettings.html'
          controller: 'SideNavSettingsCtrl')

      .state('organizationSettings',
      title: 'Организации'
      url: '/settings/organizations'
      sideNav: true
      parent: 'onlyusers'
      views:
        '@':
          templateUrl: 'user/tmpl/_organizationSettings.html'
          controller: 'OrganizationCtrl'
        'sideNav@':
          templateUrl: 'user/tmpl/_sideNavSettings.html'
          controller: 'SideNavSettingsCtrl')

      .state('organizationCreateSettings',
      title: 'Добавить организацию'
      url: '/settings/organizations/new'
      sideNav: true
      parent: 'onlyusers'
      views:
        '@':
          templateUrl: 'organization/tmpl/_new.html'
          controller: 'OrganizationCtrl'
        'sideNav@':
          templateUrl: 'user/tmpl/_sideNavSettings.html'
          controller: 'SideNavSettingsCtrl')

      .state('userOrganizationAddSettings',
      title: 'Присоединиться к организации'
      url: '/settings/organizations/add/{id:int}'
      sideNav: true
      parent: 'onlyusers'
      views:
        '@':
          templateUrl: 'userOrganization/tmpl/_new.html'
          controller: 'AddUserOrganizationCtrl'
        'sideNav@':
          templateUrl: 'user/tmpl/_sideNavSettings.html'
          controller: 'SideNavSettingsCtrl')

          .state('userOrganizationAdmin',
      title: 'Администрирование организации'
      url: '/organization/{id:int}/admin'
      sideNav: true
      parent: 'onlyusers'
      views:
        '@':
          templateUrl: 'userOrganization/tmpl/_usersList.html'
          controller: 'UserOrganizationAdminCtrl'
        'sideNav@':
          templateUrl: 'user/tmpl/_sideNavSettings.html'
          controller: 'SideNavSettingsCtrl')

      .state('user',
      title: 'Портфолио пользователя'
      url: '/{id:int}'
      templateUrl: 'user/_portfolio.html'
      controller: 'PortfolioCtrl'
      parent: 'getuser')

      .state('auth',
      title: 'Авторизация'
      url: '/auth'
      templateUrl: 'auth/_auth.html'
      controller: 'AuthCtrl'
      parent: 'onlyguest')

      .state('register',
      title: 'Создать электроное портфолио'
      url: '/register'
      templateUrl: 'auth/_register.html'
      controller: 'AuthCtrl'
      parent: 'onlyguest')

      .state('projects',
      title: 'Мои проекты'
      url: '/projects'
      templateUrl: 'project/_list.html'
      controller: 'ProjectCtrl'
      parent: 'onlyusers')

      .state('projectNew',
      title: 'Добавить проект'
      url: '/projects/new'
      templateUrl: 'project/_new.html'
      controller: 'ProjectCtrl'
      parent: 'onlyusers')

      .state('projectDetail',
      title: 'Информация о проекте'
      url: '/{executerId:int}/projects/{projectId:int}'
      templateUrl: 'project/_detail.html'
      controller: 'ProjectDetailCtrl'
      parent: 'getuser')

      .state('projectExecuterNew',
      title: 'Сообщить об участии'
      url: '/project-executer/{projectId:int}/new'
      templateUrl: 'projectExecuter/tmpl/_new.html'
      controller: 'CreateProjectExecuterCtrl'
      parent: 'onlyusers')

      .state('projectExecuterUpdate',
      title: 'Информация об участии'
      url: '/project-executer/{projectExecuterId:int}/update'
      templateUrl: 'projectExecuter/tmpl/_update.html'
      controller: 'ProjectExecuterCtrl'
      parent: 'onlyusers')

      .state('orderProjects',
      title: 'Зказываемые проекты'
      url: '/order-projects'
      templateUrl: 'orderProject/tmpl/_list.html'
      controller: 'OrderProjectCtrl'
      parent: 'onlyusers')

      .state('orderProjectsCreate',
      title: 'Заказать проект'
      url: '/order-projects/new'
      templateUrl: 'orderProject/tmpl/_new.html'
      controller: 'CreateOrderProjectCtrl'
      parent: 'onlyusers')

      .state('orderProjectDetail',
      title: 'Информация о заказываемом проекте'
      url: '/order-projects/{orderProjectId:int}'
      templateUrl: 'orderProject/tmpl/_detail.html'
      controller: 'DetailOrderProjectCtrl'
      parent: 'onlyusers')

      .state('orderProjectUpdate',
      title: 'Обновить заказываемый проект'
      url: '/order-projects/{orderProjectId:int}/update'
      templateUrl: 'orderProject/tmpl/_update.html'
      controller: 'DetailOrderProjectCtrl'
      parent: 'onlyusers')

      .state('orderExecuterRequests',
      title: 'Предложения на выполнение проектов'
      url: '/order-executer-requests'
      templateUrl: 'orderExecuterRequest/tmpl/_list.html'
      controller: 'OrderExecuterRequestCtrl'
      parent: 'onlyusers')

      .state('orderExecuterRequestCreate',
      title: 'Предложение стать исполнителем'
      url: '/order-projects/{orderProjectId:int}/requests/new'
      templateUrl: 'orderExecuterRequest/tmpl/_new.html'
      controller: 'CreateOrderExecuterRequestCtrl'
      parent: 'onlyusers')

      .state('dialog',
      title: 'Диалог'
      url: '/dialog/{second:int}'
      templateUrl: 'message/tmpl/_dialog.html'
      controller: 'DialogMessageCtrl'
      parent: 'onlyusers')

      .state 'search',
      parent: 'getuser'
      title: 'Поиск'
      sideNav: true
      url: '/search'
      reloadOnSearch: false
      disablePadding: true
      resolve:
        cities: (City) ->
          City.query().then (result) ->
            result
        categories: (Category) ->
          Category.query().then (result) ->
            result
      views:
        '@':
          templateUrl: 'search/_list.html'
          controller: 'SearchCtrl'
        'sideNav@':
          templateUrl: 'search/_filters.html'
          controller: 'SearchFilterCtrl'
    $urlRouterProvider.otherwise 'home'
]).run [
  '$rootScope'
  '$state'
  'Auth'
  ($rootScope, $state, Auth) ->
    $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
      $rootScope.sideNav = ! !toState.sideNav
      # показать сайд бар справа
      $rootScope.title = if toState.title then toState.title else ''
      # title страницы
      $rootScope.disablePadding = ! !toState.disablePadding
      # отключить паддинг в мейне
      $rootScope.from = fromState
      # предыдущее состояние
    $rootScope.$on 'devise:login', (event, currentUser) ->
      $rootScope.signedIn = Auth.isAuthenticated()
      $rootScope.authUser = currentUser
      $rootScope.logout = Auth.logout
    $rootScope.$on 'devise:new-registration', (e, currentUser) ->
      $rootScope.authUser = currentUser
      $rootScope.signedIn = true
    $rootScope.$on 'devise:logout', (e, currentUser) ->
      $rootScope.authUser = `undefined`
      $rootScope.signedIn = false
      $state.go 'home'
]
