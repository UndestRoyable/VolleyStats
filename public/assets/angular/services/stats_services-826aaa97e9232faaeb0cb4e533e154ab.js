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
    getTeamPlayers:function(team_id){
      var promise = $http.get('/api/team_players').then(function (response) {
        return response.data;
      });

      return promise;
    },

    getCities:function(){
      var promise = $http.get('/api/cities').then(function (response) {
        return response.data;
      });

      return promise;
    },

    getHalls:function(city_id){
      var promise = $http.get('/api/halls/'+ city_id).then(function (response) {
        return response.data;
      });

      return promise;
    },

    getReferees:function(){
      var promise = $http.get('/api/referees').then(function (response) {
        return response.data;
      });

      return promise;
    },

    getHours:function(){
      var promise = $http.get('/api/hours').then(function (response) {
        return response.data;
      });

      return promise;
    },

    getMinutes:function(){
      var promise = $http.get('/api/minutes').then(function (response) {
        return response.data;
      });

      return promise;
    },


    submitMatch: function(match) {
      var promise = $http.post('/api/save_match', match).then(function(response) {
        return response.data;
      });

      return promise;
    },

    addGame: function(host, guest, set) {
      var promise = $http.post('/api/add_game', {host_id: host, guest_id: guest, set: set} ).then(function(response) {
        return response.data;
      });

      return promise;
    },

    submitMatchStatistic: function(match) {
      var promise = $http.post('/api/save_match_statistic', match).then(function(response) {
        return response.data;
      });

      return promise;
    }

  }


  return statsServices;
}]);
