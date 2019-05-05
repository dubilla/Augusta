class RosterPlayerStatus

  def initialize tournament_external_id, athlete_external_id, completed
    @tournament_external_id = tournament_external_id
    @athlete_external_id = athlete_external_id
    @completed = completed
  end

  def status
    roster_player_thru || "cut"
  end

  private

  def roster_player_thru
    @roster_player_thru ||= RosterPlayerThruParser.new(tournament_athlete, tournament_round).thru
  end

  def tournament_athlete
    @tournament_athlete ||= TournamentAthleteFetcher.new(@tournament_external_id, @athlete_external_id, @completed).tournament_athlete
  end

  def tournament_round
    @tournament_round ||= TournamentDataFetcher.new(@tournament_external_id, @completed).round
  end
end
