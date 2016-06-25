angular.module('portfolus')
// извлечение URL из домена
.filter('domenFromUrl', function() {
  return function(input) {
    if (input === undefined || input.length == 0) {
      return "";
    }

    var domain;

    //find & remove protocol (http, ftp, etc.) and get domain
    if (input.indexOf("://") > -1) {
        domain = input.split('/')[2];
    } else {
        domain = input.split('/')[0];
    }

    a = document.createElement('a');
    a.href = "http://" + domain;

    var parts = a.hostname.split('.');

    if (parts.length < 2) {
      return "";
    }

    var rootDomain = parts[parts.length - 2] + "." + parts[parts.length - 1]

    return rootDomain;
  };
})
.filter('range', function() {
  return function(input, total) {
    total = parseInt(total);

    for (var i=0; i<total; i++) {
      input.push(i);
    }

    return input;
  };
})
.filter('monthName', [function() {
    return function (monthNumber) {
        var monthNames = [ 'Я', 'Ф', 'М', 'А', 'М', 'И',
            'И', 'А', 'С', 'О', 'Н', 'Д' ];
        return monthNames[monthNumber - 1];
    }
}]);
