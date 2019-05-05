class RosterPlayerStatus

  def initialize tournament_external_id, athlete_external_id, completed
    @tournament_external_id = tournament_external_id
    @athlete_external_id = athlete_external_id
    @completed = completed
  end

  def status
    if linescores.present? && tournament_round.present? && linescores[tournament_round - 1]
      linescores[tournament_round - 1]["thru"]
    else
      'cut'
    end
  end

  private

  def tournament_round
    @tournament_round ||= TournamentDataFetcher.new(@tournament_external_id, @completed).round
  end

  def tournament_athlete
    @tournament_athlete ||= TournamentAthleteFetcher.new(@tournament_external_id, @athlete_external_id, @completed).tournament_athlete
  end

  def linescores
    return unless tournament_athlete.present?
    tournament_athlete["linescores"]
  end
end
