class League < ApplicationRecord

  has_paper_trail

  has_many :league_tournaments
  has_many :tournaments, through: :league_tournaments
  has_many :teams, inverse_of: :league

  def active_league_tournament
    league_tournaments.active.first
  end

  # Ransack 4 allowlist for ActiveAdmin filtering/sorting.
  def self.ransackable_attributes(_auth_object = nil)
    %w[id name created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[league_tournaments tournaments teams]
  end
end
