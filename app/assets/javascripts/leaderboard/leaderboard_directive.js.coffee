angular.module('leaderboard')
.directive('playerLeaders', ['playerLeadersService', '$interval', (playerLeadersService, $interval) ->
  restrict: 'A'
  link: ($scope) ->
    # need to init these values
    load = ->
      playerLeadersService.getAllLeaders($scope.leagueID, $scope.tournamentID).success (response) ->
        $scope.playerLeaders = response
    $interval ->
      load()
    , 60 * 1000

    load()
])
