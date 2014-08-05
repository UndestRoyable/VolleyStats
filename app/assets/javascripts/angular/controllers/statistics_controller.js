angular.module('stats').controller('statistics_controller', ['$scope', 'statsServices', '$parse', '$compile', function($scope, statsServices, $parse, $compile) {
  console.log('statistics_controller loaded...');
  $scope.match = {};
  $scope.match.set = {};

  var split = window.location.pathname.split("/")
  $scope.match.id = parseInt(split[split.length-1])

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

  $scope.addNewGame = function(){
    if($scope.current_set > 4)
      return;
    if($scope.adding_set > 4)
      return;

    if($scope.adding_set == undefined)
      $scope.adding_set = $scope.current_set;

    $scope.adding_set += 1;
    $("#new_game").show();
    statsServices.addGame($scope.host_id, $scope.guest_id, $scope.adding_set).then(function(response){
      processNewSet(response);
    });
  };
  
  $scope.submit_match_statistic = function() {
    console.log('submit_match_statistic');
    statsServices.submitMatchStatistic($scope.match).then(function(response) {
      console.log('match submited...');
      console.log("Response: " + response);
      //check for errors 

      if(response.not_your_match != undefined){
        alert("Това не е ваш мач!")
        return;
      }

      var protocol = window.location.protocol;
      var host = window.location.host;
      var http = protocol + "//" + host + "/";
      window.location.replace(http + response.id);
    });
  }

  $scope.host_score = function(){
    try
    {
      var sum = 0;
      for (var i = 1; i <= $scope.current_set; i++) {
        var result = $scope.match.set[i].result.split("-")
        sum += parseInt(result[0]) > parseInt(result[1]) ? 1 : 0;
      };
      return sum;
    }
    catch(ex){
      return 0;
    }
  }

  $scope.guest_score = function(){
    try
    {
      var sum = 0;
      for (var i = 1; i <= $scope.current_set; i++) {
        var result = $scope.match.set[i].result.split("-")
        sum += parseInt(result[1]) > parseInt(result[0]) ? 1 : 0;
      };
      return sum;
    }
    catch(ex){
      return 0;
    }
  }

  $scope.partial = function(partial, set){
    if(partial == 1){
      $scope.match.set[set].partial1 = getPartialValue($scope.match.set[set].partial1);
    }
    else if(partial == 2){
      $scope.match.set[set].partial2 = getPartialValue($scope.match.set[set].partial2);
    }
    else if(partial == 3){
      $scope.match.set[set].partial3 = getPartialValue($scope.match.set[set].partial3);
    }
    else if(partial == 4){
      $scope.match.set[set].result = getPartialValue($scope.match.set[set].result);
    }
  }

  function getPartialValue(value){
    var result = "";
    var minus = 0;
    if(value == '' || value == undefined)
      return '0-0';
    for (var i = 0; i < value.length; i++) {
      if(value[i] == '-')
        minus += 1;
      if(minus > 1)
        return result;
      if(value[i] > '9' || value[i] < '0')
      {
        if(value[i] != '-')
          return result;
      }
      if(result == '-')
        return "0-0";
      result += value[i];
    };
    return result;
  }

  $scope.duration_sum = function(){
    try
    {
      var sum = 0;
      for (var i = 1; i <= $scope.current_set; i++) {
        sum += parseInt($scope.match.set[i].duration)
      };
      return sum;
    }
    catch(ex){
      return 0;
    }
  }

  $scope.partial1_sum = function(){
    try
    {
      var sum1 = 0;
      var sum2 = 0

      for (var i = 1; i <= $scope.current_set; i++) {
        var split = $scope.match.set[i].partial1.split("-");
        sum1 += parseInt(split[0]);
        sum2 += parseInt(split[1])
      };
      return sum1 +"-"+sum2;
    }
    catch(ex){
      return 0;
    }
  }

  $scope.partial2_sum = function(){
    try
    {
      var sum1 = 0;
      var sum2 = 0

      for (var i = 1; i <= $scope.current_set; i++) {
        var split = $scope.match.set[i].partial2.split("-");
        sum1 += parseInt(split[0]);
        sum2 += parseInt(split[1])
      };
      return sum1 +"-"+sum2;
    }
    catch(ex){
      return 0;
    }
  }

  $scope.partial3_sum = function(){
    try
    {
      var sum1 = 0;
      var sum2 = 0

      for (var i = 1; i <= $scope.current_set; i++) {
        var split = $scope.match.set[i].partial3.split("-");
        sum1 += parseInt(split[0]);
        sum2 += parseInt(split[1])
      };
      return sum1 +"-"+sum2;
    }
    catch(ex){
      return 0;
    }
  }

  $scope.result_sum = function(){
    try
    {
      var sum1 = 0;
      var sum2 = 0

      for (var i = 1; i <= $scope.current_set; i++) {
        var split = $scope.match.set[i].result.split("-");
        sum1 += parseInt(split[0]);
        sum2 += parseInt(split[1])
      };
      return sum1 +"-"+sum2;
    }
    catch(ex){
      return 0;
    }
  };

  function processNewSet(response){
    var i = 0;
    while(response[i] >= '0' && response[i] <= '9')
      i += 1;

    var set = response.substring(0,i);
    $scope.match.set[set] = {};
    $scope.match.set[set].players = {};
    $scope.match.set[set].duration = 0;
    $scope.match.set[set].partial1 = '0-0';
    $scope.match.set[set].partial2 = '0-0';
    $scope.match.set[set].partial3 = '0-0';
    $scope.match.set[set].result = '0-0';
    var html = response.substring(set.length);

    var tabs = $("#games");
    var tab = angular.element("<li><a role = 'tab' href = '#game_" + set +"' data-toggle='tab'>Гейм №" + set + "</a>");

    tabs.append(tab);

    $compile(tab)($scope);

    var tables = $("#gamesholder");
    var table = angular.element("<div id='game_"+set +"' class = 'tabdata'>" + html + "</div>");

    tables.append(table);

    $compile(table)($scope);
    $scope.current_set += 1;

    $("#new_game").hide();
  }

  function onChanged (field,player_model){
    if(typeof(field)==='undefined')
      return;
    console.log("changing " + field);
    var value = getChangeValue(field,player_model);
    console.log(value);
    var model = $parse(player_model+ "." + field);
    model.assign($scope, value);

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

onLoaded("#content");
}]);

  /*-calculates = {"reception_efficiency"=>["reception_total", "reception_errors"],
    "attack_efficiency"=>["attack_total","attack_errors","attack_blocks", "attack_points"],
  "won_lost"=>["points_total","block_points"]}*/