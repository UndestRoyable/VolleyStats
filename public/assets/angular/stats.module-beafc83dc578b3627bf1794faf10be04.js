angular.module('stats', ['stats_services']);

angular.module('stats').config(['$locationProvider', function(lProvider) {
  lProvider.html5Mode(false);
}]);

angular.module('stats').config(['$httpProvider', function(provider) {
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  provider.defaults.headers.post['Content-Type'] = 'application/json; charset=UTF-8';
}]);
