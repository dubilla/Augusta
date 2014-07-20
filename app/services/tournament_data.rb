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
    response["leagues"].first["events"].first["competitions"].first
  end

  def response
    Rails.cache.fetch("tournament/#{@id}", expires_in: 3.minutes) do
      HTTParty.get(url).to_a.flatten[1]
    end
  end

  private

  def url
    @url ||= [@host, @version, @tournament_path, @id, '?apikey=', @apiKey].join
  end

end
