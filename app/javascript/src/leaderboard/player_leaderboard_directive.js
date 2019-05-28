angular.module('leaderboard')
.directive('playerLeaders', ['leadersService', '$interval', function(leadersService, $interval) {
  return {
    restrict: 'A',
    link: ($scope) => {
      var load = function() {
        leadersService.getAllLeaders($scope.leagueID, $scope.tournamentID).success((response) => {
          $scope.playerLeaders = response.players;
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
