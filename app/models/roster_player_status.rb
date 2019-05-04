class RosterPlayerStatus

  def initialize tournament_external_id, athlete_external_id, completed
    @tournament_external_id = tournament_external_id
    @athlete_external_id = athlete_external_id
    @completed = completed
  end

  def status
    if linescores.present? && tournament.round.present? && linescores[tournament.round - 1]
      linescores[tournament.round - 1]["thru"]
    else
      'cut'
    end
  end

  private

  def tournament
    @tournament ||= TournamentData.new(@tournament_external_id, @completed)
  end

  def tournament_athlete
    @tournament_athlete ||= TournamentAthleteFetcher.new(@tournament_external_id, @athlete_external_id, @completed).tournament_athlete
  end

  def linescores
    return unless tournament_athlete.present?
    tournament_athlete["linescores"]
  end
end
