angular.module('stats').controller('user_view', ['$scope', 'statsServices', function($scope, statsServices) {
  console.log('user_view loaded...');
  $scope.onTeamSelect = function(){
    setTimeout(function(){$("#player").select2();}, 100);
    if($scope.current_team == undefined || $scope.current_team == 0 )
      $scope.currentPlayers = {};
    else
    {
      $scope.currentPlayers = [];
      for (var i = 0; i < $scope.players.length; i++) {
        if($scope.players[i].team_id == $scope.current_team)
          $scope.currentPlayers.push($scope.players[i])
      };
      $scope.player = 0
    }
  };

  statsServices.getTeams().then(function(response) {
    $scope.teams = response;
    statsServices.getTeamPlayers().then(function(response){
      $scope.players = response;
      $scope.onTeamSelect();
    });
  });
}]);
