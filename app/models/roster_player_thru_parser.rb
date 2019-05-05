class RosterPlayerThruParser

  def initialize tournament_athlete, round
    @tournament_athlete = tournament_athlete
    @round = round
  end

  def thru
    return unless linescores.present? && @round.present? && linescores[@round - 1]
    linescores[@round - 1]["thru"]
  end

  private

  def linescores
    return unless @tournament_athlete.present?
    @tournament_athlete["linescores"]
  end
end
