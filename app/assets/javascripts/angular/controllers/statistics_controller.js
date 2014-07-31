angular.module('stats').controller('statistics_controller', ['$scope', 'statsServices', '$parse', function($scope, statsServices, $parse) {
  console.log('statistics_controller loaded...');
  $scope.match = {};
  $scope.match.set = {};

  $scope.increase = function(field,calculate, player_model){
    var model = $parse(field);
    model.assign($scope, model($scope) + 1);
    change(calculate,player_model)
  };

  $scope.decrease = function(field,calculate, player_model){
    var model = $parse(field);
    model.assign($scope, model($scope) - 1);
    console.log(model)
    console.log(model($scope))
    
    //change(calculate,player_model)
  };


  function change (field,player_model){
    if(typeof(field)==='undefined')
      return;
    console.log("changing " + field)
    var value = getValue(field,player_model)
    console.log(value)
    var model = $parse(player_model+ "." + field); 
    model.assign($scope, value);

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
  function getV(field){
    var model = $parse(field); 
    return model($scope);
  };

  function getValue (field,player_model){

    if(field == 'won_lost')
    {
      return getV(player_model+".points_total") +getV(player_model + ".block_points")
    }
    else if (field == 'attack_efficiency')
    {
      return 1;
    }
    else if (field == 'reception_efficiency')
    {
      return parseInt(getV(player_model +".reception_total")) / parseInt(getV(player_model + ".reception_errors"));
    }
    else alert("Unhandled field " + field)
  };


}]);


  /*-calculates = {"reception_efficiency"=>["reception_total", "reception_errors"],
    "attack_efficiency"=>["attack_total","attack_errors","attack_blocks", "attack_points"],
  "won_lost"=>["points_total","block_points"]}*/