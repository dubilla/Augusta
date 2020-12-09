angular.module('leaderboard')
.directive('teamLeaders', ['rostersService', '$interval', function(rostersService, $interval) {
  return {
    restrict: 'A',
    link: ($scope) => {
      var load = function() {
        rostersService.getAll($scope.leagueTournamentID).success((response) => {
          $scope.teamLeaders = response.data.map(function(team) {
            return {
              id: team.id,
              name: team.attributes["name"],
              score: team.attributes["score"]
            };
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
