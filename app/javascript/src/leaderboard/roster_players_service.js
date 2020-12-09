angular.module('leaderboard')
.factory('rosterPlayersService', ['$http', function($http) {
  var service = {};

  service.getAll = (leagueTournamentId) =>
    $http.get('/api/v1/roster_players?league_tournament_id=' + leagueTournamentId)

  return service;
}]);
