angular.module('stats').controller('statistics_controller', ['$scope', 'statsServices', '$parse', function($scope, statsServices, $parse) {
  console.log('statistics_controller loaded...');
  $scope.match = {};
  $scope.match.set = {};

  $scope.increase = function(field){
    var model = $parse(field);
    model.assign($scope, model($scope) + 1);
  };

  $scope.decrease = function(field){
    var model = $parse(field);
    model.assign($scope, model($scope) - 1);
  };

  $scope.addNewGame = function(){
    if($scope.current_set > 4)
      return;
    $scope.current_set += 1;
    statsServices.addGame($scope.host_id, $scope.guest_id, $scope.current_set).then(function(response){
      processNewSet(response);
    });
};

  function processNewSet(response){
    var i = 0;
    while(response[i] >= '0' && response[i] <= '9')
      i += 1;

    var set = response.substring(0,i);
    $scope.match.set[set] = {};
    $scope.match.set[set].players = {};
    var html = response.substring(set.length);

    var tab = $("<li><a role = 'tab' href = '#game_" + set +"' data-toggle='tab'>Гейм №" + set + "</a>");
    var tabs = $("#games");

    tabs.append(tab);

    var tables = $("#tables");
    var table = $("<div id='game_"+set +"' class = 'tabdata'>" + html + "</div>");

    tables.append(table);
  }
}]);
