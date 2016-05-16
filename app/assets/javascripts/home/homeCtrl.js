angular.module('portfolus')
.controller('HomeCtrl',
function($scope, Page) {
  Page.setTitle('профессиональное портфолио')
  .setSideNav(true);
});
