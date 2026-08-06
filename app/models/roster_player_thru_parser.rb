class RosterPlayerThruParser

  def initialize tournament_external_id, athlete_external_id, completed
    @tournament_external_id = tournament_external_id
    @athlete_external_id = athlete_external_id
    @completed = completed
  end

  def thru
    return unless linescores.present? && round.present? && linescores[round - 1] && linescores[round - 1]["thru"] != 0
    linescores[round - 1]["thru"]
  end

  def tee_time
    return unless status.present? && status['state'] == 'pre'
    status['detail']
  end

  private

  def linescores
    return unless tournament_athlete.present?
    tournament_athlete["linescores"]
  end

  def status
    return unless tournament_athlete.present?
    tournament_athlete["status"]
  end

  def round
    @round ||= TournamentDataFetcher.new(@tournament_external_id, @completed).round
  end

  def tournament_athlete
    @tournament_athlete ||= TournamentAthleteFetcher.new(@tournament_external_id, @athlete_external_id, @completed).tournament_athlete
  end
end
