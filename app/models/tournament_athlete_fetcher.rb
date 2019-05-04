class TournamentAthleteFetcher

  def initialize tournament_external_id, athlete_external_id, completed
    @tournament_external_id = tournament_external_id
    @athlete_external_id = athlete_external_id
    @completed = completed
  end

  def tournament_athlete
    tournament.athletes.detect{ |g| g["athlete"]["id"] == @athlete_external_id }
  end

  private

  def tournament
    @tournament ||= TournamentData.new(@tournament_external_id, @completed)
  end
end
