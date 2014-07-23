angular.module('stats').controller('stats_controller', ['$scope', 'statsServices', function($scope, statsServices) {
  console.log('stats_controller loaded...');

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
    console.log($scope.match.host_id);
    $scope.host_players = getPlayers($scope.match.host_id);
  }

  $scope.guest_team_changed = function() {
    console.log('guest_team_changed');
    console.log($scope.match.guest_id);
    $scope.guest_players = getPlayers($scope.match.guest_id);
  }

  function getPlayers(team_id){
    return statsServices.getPlayers(team_id);
  }

  $scope.submit_match_info = function() {
    console.log('submit_match_info');
    statsServices.submitMatch($scope.match).then(function(response) {
      console.log('match submited...');
      console.log('TODO: now redirect me!');

      console.log(response);
    });
  }
}]);
