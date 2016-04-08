class RosterPlayer < ActiveRecord::Base

  belongs_to :roster
  belongs_to :player

  delegate :external_id, to: :player
  delegate :name, to: :player
  delegate :league_tournament, to: :roster

  def score
    tournament_athlete["score"].to_i
  end

  def status
    tournament_athlete["linescores"][tournament.round - 1]["thru"]
  end

  def tournament_athlete
    tournament_golfers.detect{ |g| g["athlete"]["id"] == external_id }
  end

  private

  def tournament_golfers
    tournament.athletes
  end

  def tournament
    @tournament ||= TournamentData.new(league_tournament.external_id, league_tournament.completed)
  end
end
