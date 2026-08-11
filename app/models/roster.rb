class Roster < ActiveRecord::Base

  has_paper_trail

  has_many :roster_players
  has_many :players, through: :roster_players
  belongs_to :team
  belongs_to :league_tournament

  delegate :user, to: :team
  delegate :name, to: :user, prefix: true

  scope :winner, -> { where winner: true }

  accepts_nested_attributes_for :roster_players

  # Ransack 4 allowlist for ActiveAdmin filtering/sorting.
  def self.ransackable_attributes(_auth_object = nil)
    %w[id team_id league_tournament_id winner created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[team league_tournament roster_players players]
  end

  def score
    roster_players.map{|p| p.score}.reduce(:+)
  end

  def final_score
    roster_players.sum(:final_score)
  end
end
