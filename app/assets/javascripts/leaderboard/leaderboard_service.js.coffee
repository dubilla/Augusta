angular.module('leaderboard')
.factory('leadersService', ['$http', ($http) ->

  getAllLeaders: (leagueID, tournamentID) ->
    $http.get('/leagues/' + leagueID + '/tournaments/' + tournamentID + '/leaderboard.json')
])
