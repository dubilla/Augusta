angular.module('leaderboard')
.directive('playerLeaders', ['playerLeadersService', (playerLeadersService) ->
  restrict: 'A'
  link: ($scope) ->
    # need to init these values
    playerLeadersService.getAllLeaders($scope.leagueID, $scope.tournamentID).success (response) ->
      $scope.playerLeaders = response

])
