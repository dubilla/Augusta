class RosterPlayerScoreParser

  def initialize tournament_external_id, athlete_external_id, completed
    @tournament_external_id = tournament_external_id
    @athlete_external_id = athlete_external_id
    @completed = completed
  end

  def score
    return unless tournament_athlete["score"]
    tournament_athlete["score"].to_i
  end

  private

  def tournament_athlete
    @tournament_athlete ||= TournamentAthleteFetcher.new(@tournament_external_id, @athlete_external_id, @completed).tournament_athlete
  end
end
