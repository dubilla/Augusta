angular.module('leaderboard')
.service('leadersService', ['$http', ($http) ->

  getAllLeaders: (leagueID, tournamentID) ->
    $http.get('/leagues/' + leagueID + '/tournaments/' + tournamentID + '/leaderboard.json')
])
