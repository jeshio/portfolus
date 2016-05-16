angular.module('portfolus')
.controller('AuthCtrl',
function($scope, Page){
  Page.setTitle('авторизация')
  .setSideNav(false);
});
