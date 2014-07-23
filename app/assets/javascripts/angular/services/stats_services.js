var stats_services = {};
var stats_services = angular.module('stats', []);

stats_services.factory('statsServices', ['$http', function($http) {
  var statsServices = {
    getTeams: function() {
      var promise = $http.get('/api/teams').then(function (response) {
        return response.data;
      });

      return promise;
    },
    getPlayers:function(team_id){
      var promise = $http.get('/api/players/'+ team_id).then(function (response) {
        return response.data;
      });

      return promise;
    },

    submitMatch: function(match) {
      var promise = $http.post('/api/save_match', match).then(function(response) {
        return response.data;
      });

      return promise;
    }

  }

  return statsServices;
}]);
