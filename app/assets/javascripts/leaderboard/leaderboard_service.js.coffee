angular.module('leaderboard')
.service('playerLeadersService', ['$http', ($http) ->

  getAllLeaders: (leagueID, tournamentID) ->
    $http.get('/leagues/' + leagueID + '/tournaments/' + tournamentID + '/leaderboard.json')
])
