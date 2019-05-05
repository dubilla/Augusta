class TournamentData

  def initialize id, completed
    @host = 'http://api.espn.com/'
    @version = 'v1/'
    @tournament_path = 'sports/golf/pga/events/'
    @id = id
    @apiKey = 'dv58z289n3pf5yw4gxrpzrwq'
    @completed = completed
  end

  def athletes
    event["competitors"]
  end

  def round
    event["period"]
  end

  private

  def response
    Rails.cache.fetch("tournament/#{@id}", expires_in: expiration_time) do
      Hash[HTTParty.get(url)]
    end
  end

  def event
    response["sports"].first["leagues"].first["events"].first["competitions"].first
  end

  def url
    @url ||= [@host, @version, @tournament_path, @id, '?apikey=', @apiKey].join
  end

  def expiration_time
    if @completed
      7.days
    else
      1.minute
    end
  end

end
