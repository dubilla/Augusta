class LeagueTournament < ApplicationRecord

  has_paper_trail

  belongs_to :league
  belongs_to :tournament
  has_many :rosters
  has_many :roster_players, through: :rosters

  delegate :external_id, to: :tournament
  delegate :start_date, to: :tournament
  delegate :completed, to: :tournament
  delegate :name, to: :tournament

  scope :active, -> { joins(:tournament).merge(Tournament.active) }

  # Ransack 4 allowlist for ActiveAdmin filtering/sorting.
  def self.ransackable_attributes(_auth_object = nil)
    %w[id league_id tournament_id created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[league tournament rosters roster_players]
  end

end
