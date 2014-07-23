angular.module('stats').controller('stats_controller', ['$scope', 'statsServices', function($scope, statsServices) {
  console.log('stats_controller loaded...');

  statsServices.getTeams().then(function(response) {
    $scope.host_teams = response;
    $scope.guest_teams = response;
    console.log($scope.teams);
  });

  $scope.host_team_changed = function() {
    console.log('host_team_changed');
    console.log($scope.match.host_id);
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
