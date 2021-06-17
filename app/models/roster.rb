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

  def score
    roster_players.map{|p| p.score}.reduce(:+)
  end

  def final_score
    roster_players.sum(:final_score)
  end
end
