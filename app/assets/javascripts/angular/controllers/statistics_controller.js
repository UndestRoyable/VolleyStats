angular.module('stats').controller('statistics_controller', ['$scope', 'statsServices', '$parse', function($scope, statsServices, $parse) {
  console.log('statistics_controller loaded...');
  $scope.match = {};
  $scope.match.set = {};

  $scope.increase = function(field,calculate, player_model){
    var model = $parse(field);
    var value = model($scope) + 1;
    model.assign($scope, value);
    onChanged(calculate,player_model);
  };

  $scope.decrease = function(field,calculate, player_model){
    var model = $parse(field);
    var value = model($scope) - 1;
    if(value < 0) value = 0;
    model.assign($scope, value);
    
    onChanged(calculate,player_model);
  };


  function onChanged (field,player_model){
    if(typeof(field)==='undefined')
      return;
    console.log("changing " + field);
    var value = getChangeValue(field,player_model);
    console.log(value);
    var model = $parse(player_model+ "." + field);
    model.assign($scope, value);

  }


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

  function getInt(field){
    return parseInt(getValue(field));
  }

  function getValue(field){
    var model = $parse(field);
    return model($scope);
  }

  function getChangeValue (field,player_model){
    var value = 0;

    if(field == 'won_lost')
    {
      value = getInt(player_model+".points_total") + getInt(player_model + ".block_points");
    }
    else if (field == 'attack_efficiency')
    {
      value = 1;
    }
    else if (field == 'reception_efficiency')
    {
      var errors = getInt(player_model + ".reception_errors");
      var total = getInt(player_model +".reception_total");

      value = errors / total;
      if(total == errors)
        value = 0;
      else if(total === 0 && errors > 0)
        value = 0;
      else if(total > 0 && errors === 0)
        value = 100;
      else if(errors === 0 && total === 0)
        value = 0;
      else if(errors > total)
        value = 0;
      else value = 100 - parseInt(value * 100);
    }
    else alert("Unhandled field " + field);

    return value;
  }


}]);


  /*-calculates = {"reception_efficiency"=>["reception_total", "reception_errors"],
    "attack_efficiency"=>["attack_total","attack_errors","attack_blocks", "attack_points"],
  "won_lost"=>["points_total","block_points"]}*/