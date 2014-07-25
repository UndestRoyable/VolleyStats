angular.module('stats').controller('stats_controller', ['$scope', 'statsServices', function($scope, statsServices) {
  console.log('stats_controller loaded...');
  $scope.match = {};
  statsServices.getTeams().then(function(response) {
    $scope.teams = response;
    $scope.host_teams = function(){

      if($scope.match != undefined && $scope.match.guest_id != undefined)
        return $scope.teams.select(function(x){return x.id != $scope.match.guest_id;})
      return $scope.teams;
    };

    $scope.guest_teams = function(){
       if($scope.match != undefined && $scope.match.host_id != undefined)
        return $scope.teams.select(function(x){return x.id != $scope.match.host_id;})
      return $scope.teams;
    };
    console.log($scope.teams);
  });

  $scope.host_team_changed = function() {
    console.log('host_team_changed');
    if($scope.host != null)
      $scope.match.host_id = $scope.host.id; 
    else {
      $scope.match.host_id = undefined;
      $scope.host_players = [];
      return;
    }
    console.log($scope.match.host_id)

    statsServices.getPlayers($scope.match.host_id).then(function(response){
      $scope.host_players = response;
    });
  }

  $scope.guest_team_changed = function() {
    console.log('guest_team_changed');
    if($scope.guest != null)
      $scope.match.guest_id = $scope.guest.id;
    else {
      $scope.match.guest_id = undefined;
      $scope.guest_players = [];
      return;
    }

    statsServices.getPlayers($scope.match.guest_id).then(function(response){
      $scope.guest_players = response;
    });
  }
  
  statsServices.getCities().then(function(response) {
  $scope.cities = response;
  });

  $scope.city_changed = function() {
    console.log('city_changed');
    console.log($scope.match.city_id);
    $scope.halls = statsServices.getHalls($scope.match.city_id);
  }
  
  statsServices.getReferees().then(function(response) {
    $scope.referees = response;
    $scope.first_referees = function(){

      if($scope.match != undefined && $scope.match.second_referee_id != undefined)
        return $scope.referees.select(function(x){return x.id != $scope.match.second_referee_id;})
      return $scope.referees;
    };

    $scope.second_referees = function(){
       if($scope.match != undefined && $scope.match.first_referee_id != undefined)
        return $scope.referees.select(function(x){return x.id != $scope.match.first_referee_id;})
      return $scope.referees;
    };
    console.log($scope.referees);
  });

    statsServices.getHours().then(function(response) {
  $scope.hours = response;
  });

    statsServices.getMinutes().then(function(response) {
  $scope.minutes = response;
  });

  $scope.submit_match_info = function() {
    console.log('submit_match_info');
    console.log($scope.match)
    statsServices.submitMatch($scope.match).then(function(response) {
      console.log('match submited...');
      console.log(location);
      var protocol = window.location.protocol;
      var host = window.location.host;
      var http = protocol + "//" + host + "/";
      window.location.replace(http + response);
      console.log(response);
    });
  }

}]);
