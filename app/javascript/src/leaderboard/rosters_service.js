angular.module('leaderboard')
.factory('rostersService', ['$http', function($http) {
  var service = {};

  service.getAll = (leagueTournamentId) =>
    $http.get('/api/v1/rosters?league_tournament_id=' + leagueTournamentId)

  return service;
}]);
