class RosterPlayer < ActiveRecord::Base

  has_paper_trail

  belongs_to :roster
  belongs_to :player

  delegate :external_id, to: :player
  delegate :name, to: :player
  delegate :league_tournament, to: :roster
  delegate :team, to: :roster
  delegate :user, to: :team
  delegate :name, to: :user, prefix: true

  scope :winner, -> { where winner: true }

  def score
    if tournament_athlete.present?
      tournament_athlete["score"].to_i
    else
      0
    end
  end

  def status
    if linescores.present? && tournament.round.present? && linescores[tournament.round - 1]
      linescores[tournament.round - 1]["thru"]
    else
      'cut'
    end
  end

  private

  def tournament_athlete
    tournament.athletes.detect{ |g| g["athlete"]["id"] == external_id }
  end

  def linescores
    return unless tournament_athlete.present?
    tournament_athlete["linescores"]
  end

  def tournament
    @tournament ||= TournamentData.new(league_tournament.external_id, league_tournament.completed)
  end
end
