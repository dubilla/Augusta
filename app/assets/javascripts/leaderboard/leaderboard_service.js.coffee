angular.module('leaderboard')
.service('playerLeadersService', ['$http', ($http) ->

  getAllLeaders: ->
    # masters
    url = 'http://api.espn.com/v1/sports/golf/pga/events/1317?apikey=dv58z289n3pf5yw4gxrpzrwq'
    $http.get(url)
])
