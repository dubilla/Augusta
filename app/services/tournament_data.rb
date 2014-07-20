class TournamentData

  def initialize id
    @host = 'http://api.espn.com/'
    @version = 'v1/'
    @tournament_path = 'sports/golf/pga/events/'
    @id = id
    @apiKey = 'dv58z289n3pf5yw4gxrpzrwq'
  end

  def athletes
    event["competitors"]
  end

  def event
    response["sports"].first["leagues"].first["events"].first["competitions"].first
  end

  def response
    HTTParty.get(url)
  end

  private

  def url
    @url ||= [@host, @version, @tournament_path, @id, '?apikey=', @apiKey].join
  end

end
