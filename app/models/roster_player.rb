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

  # Ransack 4 allowlist for ActiveAdmin filtering/sorting.
  def self.ransackable_attributes(_auth_object = nil)
    %w[id roster_id player_id winner final_score created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[roster player]
  end

  def score
    tournament_athlete_score || 0
  end

  def status
    thru || tee_time || "cut"
  end

  private

  def tournament_athlete_score
    @tournament_athlete_score ||= RosterPlayerScoreParser.new(league_tournament.external_id, external_id, league_tournament.completed).score
  end

  def thru
    @thru ||= roster_player_parser.thru
  end

  def tee_time
    @tee_time ||= roster_player_parser.tee_time
  end

  def roster_player_parser
    @roster_player_parser ||= RosterPlayerThruParser.new(league_tournament.external_id, external_id, league_tournament.completed)
  end
end
