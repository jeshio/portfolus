angular.module('portfolus')
.factory('Page', function() {
   var title = 'профессиональное портфолио';
   var showSideNav = false;
   return {
     title: function() { return title; },
     setTitle: function(newTitle) { title = newTitle; return this },

     sideNav: function() { return showSideNav; },
     setSideNav: function(status) { showSideNav = status; return this }
   };
});
