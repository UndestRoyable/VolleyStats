var statistics_services = {};
var statistics_services = angular.module('stats', []);

statistics_services.factory('statisticsServices', ['$http', function($http) {
  var statisticsServices = {
  

    addGame: function(host, guest, set) {
      var promise = $http.post('/api/add_game', {host_id: host, guest_id: guest, set: set} ).then(function(response) {
        return response.data;
      });

      return promise;
    }










    

  }

  return statisticsServices;
}]);
