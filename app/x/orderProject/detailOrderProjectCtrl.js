angular.module('portfolus')
.controller('DetailOrderProjectCtrl',['$scope', 'OrderProject', '$parse', '$state', '$stateParams', '$mdDialog', '$mdMedia', '$mdToast', 'Category', 'OrderExecuterRequest', '$filter',
function($scope, OrderProject, $parse, $state, $stateParams, $mdDialog, $mdMedia, $mdToast, Category, OrderExecuterRequest, $filter){
  // объект для формы
  $scope.orderProject = {};
  $scope.technology = {};
  $scope.orderProject.tags = [];
  $scope.orderProject.technologies = [];
  $scope.categories = [];
  $scope.orderExecuterRequests = [];
  $scope.userOrderExecuterRequest = {};

  load();

  $scope.createOrderExecuterRequest = function(ev) {
    var useFullScreen = ($mdMedia('sm') || $mdMedia('xs')) && $scope.customFullscreen;
    $mdDialog.show({
      templateUrl: 'orderExecuterRequest/tmpl/_new.html',
      controller: function ($scope, OrderExecuterRequest, $parse, $mdDialog, orderProjectId, userId) {
        // объект для формы
        $scope.orderExecuterRequest = { orderProjectId: orderProjectId, executerId: userId, byCustomer: false };

        // создать объект
        $scope.createOrderExecuterRequest = function () {
          var orderExecuterRequest = new OrderExecuterRequest($scope.orderExecuterRequest);
          orderExecuterRequest.create().then(function (result) {
            $scope.hide();
            load();
          }, function (errors) {
            var errors = errors.data;

            angular.forEach(errors, function (error, field) {
                $scope.OrderExecuterRequest.$setValidity(field, false, $scope.email);
                var serverMessage = $parse('OrderExecuterRequest.'+field+'.$error.serverMessage');
                serverMessage.assign($scope, error.join(', '));
            });
          });
        }

        $scope.hide = function() {
          $mdDialog.hide();
        };
      },
      parent: angular.element(document.body),
      targetEvent: ev,
      locals: {orderProjectId: $scope.orderProject.id, userId: $scope.authUser.id},
      clickOutsideToClose:true,
      fullscreen: useFullScreen
    }).then(function() {
   });

    $scope.$watch(function() {
      return $mdMedia('xs') || $mdMedia('sm');
    }, function(wantsFullScreen) {
      $scope.customFullscreen = (wantsFullScreen === true);
    });
  };

  $scope.deleteOrderExecuterRequest = function (ev) {
    var confirm = $mdDialog.confirm()
          .title('Отменить предложение?')
          .ariaLabel('Отмена предложения.')
          .targetEvent(ev)
          .ok('Да')
          .cancel('Нет');
    $mdDialog.show(confirm).then(function() {
      new OrderExecuterRequest($scope.userOrderExecuterRequest).delete().then(function (result) {
        $mdToast.show($mdToast.simple().textContent('Отменено.'));
        load();
      });
    });
  }

  // обновить объект
  $scope.updateOrderProject = function () {
    var orderProject = new OrderProject($scope.orderProject);
    orderProject.update().then(function (result) {
      $state.go('orderProjects');
    }, function (errors) {
      var errors = errors.data;

      angular.forEach(errors, function (error, field) {
          $scope.OrderProject.$setValidity(field, false, $scope.email);
          var serverMessage = $parse('OrderProject.'+field+'.$error.serverMessage');
          serverMessage.assign($scope, error.join(', '));
      });
    });
  }

  // удаление
  $scope.delete = function (ev) {
    var confirm = $mdDialog.confirm()
          .title('Удалить?')
          .ariaLabel('Удаление записи.')
          .targetEvent(ev)
          .ok('Да')
          .cancel('Нет');
    $mdDialog.show(confirm).then(function() {
      $scope.orderProject.delete().then(function (result) {
        $mdToast.show($mdToast.simple().textContent('Удалено.'));
        $state.go('orderProjects');
      });
    });
  }

  $scope.chooseExecuter = function (ev, request) {
    var confirm = $mdDialog.confirm()
          .title('Выбрать исполнителем?')
          .ariaLabel('Выбор исполнителя.')
          .content('Сделанный выбор отменить нельзя.')
          .targetEvent(ev)
          .ok('Да')
          .cancel('Нет');
    $mdDialog.show(confirm).then(function() {
      // подтверждаем запрос
      request.confirmed = true;
      new OrderExecuterRequest(request).update().then(function (requestResult) {
        // устанавливаем исполнителя
        $scope.orderProject.executerId = requestResult.executerId;
        $scope.orderProject.update().then(function (orderProjectResult) {
          $mdToast.show($mdToast.simple().textContent('Исполнитель выбран.'));
          load();
        });
      });
    });
  }

  // загрузка заказываемых текущим пользователем проектов
  function load() {
    OrderProject.get($stateParams.orderProjectId).then(function (result) {
      $scope.orderProject = result;
      $scope.userOrderExecuterRequest = $filter('filter')(result.orderExecuterRequests, {executerId: $scope.authUser.id}, true)[0];
    }, function (error) {
      console.log(error);
    });
  }

  Category.query().then(function (result) {
    $scope.categories = result;
  });

  function resetValidation(form) {
    $scope[form].$setPristine();
    $scope[form].$setValidity();
    $scope[form].$setUntouched();
    $scope[form].$error = {};
  }
}]);
