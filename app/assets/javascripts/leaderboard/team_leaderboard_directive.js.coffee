angular.module('leaderboard')
.directive('teamLeaders', ['leadersService', '$interval', (leadersService, $interval) ->
  restrict: 'A'
  link: ($scope) ->
    load = ->
      leadersService.getAllLeaders($scope.leagueID, $scope.tournamentID).success (response) ->
        $scope.teamLeaders = response.teams

    $interval ->
      load()
    , 60 * 1000

    load()
])
