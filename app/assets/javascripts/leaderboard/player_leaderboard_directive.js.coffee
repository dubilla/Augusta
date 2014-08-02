angular.module('leaderboard')
.directive('playerLeaders', ['leadersService', '$interval', (leadersService, $interval) ->
  restrict: 'A'
  link: ($scope) ->
    load = ->
      leadersService.getAllLeaders($scope.leagueID, $scope.tournamentID).success (response) ->
        $scope.playerLeaders = response.players
    $interval ->
      load()
    , 60 * 1000

    load()
])
