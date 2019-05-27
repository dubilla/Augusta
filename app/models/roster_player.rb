class RosterPlayer < ApplicationRecord

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
    tournament_athlete_score || 0
  end

  def status
    thru || "cut"
  end

  private

  def tournament_athlete_score
    @tournament_athlete_score ||= RosterPlayerScoreParser.new(league_tournament.external_id, external_id, league_tournament.completed).score
  end

  def thru
    @thru ||= RosterPlayerThruParser.new(league_tournament.external_id, external_id, league_tournament.completed).thru
  end
end
