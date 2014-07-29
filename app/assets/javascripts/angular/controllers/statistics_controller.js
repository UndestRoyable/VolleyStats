angular.module('stats').controller('statistics_controller', ['$scope', 'statsServices', function($scope, statsServices) {
  console.log('statistics_controller loaded...');
  $scope.match = {};
  statsServices.addGame(1,2,4).then(function(response){
  	console.log(response);
  });
  













  
  

}]);
