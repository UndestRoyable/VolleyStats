angular.module('stats').controller('statistics_controller', ['$scope', 'statsServices', function($scope, statsServices) {
  console.log('statistics_controller loaded...');
  $scope.match = {};
  statsServices.addGame(1,2,4).then(function(response){
    console.log(response.html);
    console.log(response.set);
    console.log(response);
    return;
    var tab = $("<li><a role = 'tab' href = '#game_" + response.set +"' data-toggle='tab'>Гейм №" + response.set + "</a>");
    var tabs = $("#games");

    tabs.append(tab);

    var tables = $("#tables");
    var table = $("<div id='game_"+response.set +"' class = 'tabdata'>" + response.html + "</div>");

    tables.append(table);

    console.log(response);
  });
}]);
