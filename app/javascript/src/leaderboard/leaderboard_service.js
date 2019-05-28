angular.module('leaderboard')
.factory('leadersService', ['$http', function($http) {
  var service = {};

  service.getAllLeaders = (leagueID, tournamentID) =>
    $http.get('/leagues/' + leagueID + '/tournaments/' + tournamentID + '/leaderboard.json')

  return service;
}]);
