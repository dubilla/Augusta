angular.module('leaderboard')
.directive('teamLeaders', ['leadersService', '$interval', function(leadersService, $interval) {
  return {
    restrict: 'A',
    link: ($scope) => {
      var load = function() {
        leadersService.getAllLeaders($scope.leagueID, $scope.tournamentID).success((response) => {
          $scope.teamLeaders = response.teams;
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
