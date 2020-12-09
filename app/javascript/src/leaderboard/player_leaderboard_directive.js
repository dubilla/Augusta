angular.module('leaderboard')
.directive('playerLeaders', ['rosterPlayersService', '$interval', function(rosterPlayersService, $interval) {
  return {
    restrict: 'A',
    link: ($scope) => {
      var load = function() {
        rosterPlayersService.getAll($scope.leagueTournamentID).success((response) => {
          $scope.playerLeaders = response.data.map(function(player) {
            return {
              id: player.id,
              name: player.attributes["name"],
              score: player.attributes["score"],
              user_name: player.attributes["user_name"],
              status: player.attributes["status"],
            }
          });
        });
      };
      $interval(
        load,
        60 * 1000
      );
      load();
    }
  }
}]);
