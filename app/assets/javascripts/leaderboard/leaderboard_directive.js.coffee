angular.module('leaderboard')
.directive('playerLeaders', ['playerLeadersService', (playerLeadersService) ->
  restrict: 'A'
  link: ($scope) ->
    $scope.playerLeaders = playerLeadersService.getAllLeaders().success (response) ->
      $scope.playerLeaders = response.sports[0].leagues[0].events[0].competitions[0].competitors
])
