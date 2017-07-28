class Roster < ActiveRecord::Base

  has_paper_trail

  has_many :roster_players
  has_many :players, through: :roster_players
  belongs_to :team
  belongs_to :league_tournament

  def score
    roster_players.map{|p| p.score}.reduce(:+)
  end

  def final_score
    roster_players.sum(:final_score)
  end
end
