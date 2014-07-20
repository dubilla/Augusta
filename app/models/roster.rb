class Roster < ActiveRecord::Base

  has_many :roster_players
  has_many :players, through: :roster_players
  belongs_to :team
  belongs_to :league_tournament

  def score
    roster_players.map{|p| p.score}.reduce(:+)
  end

  def tournament_athletes
    tournament_golfers.detect{ |g| g["athlete"]["id"] == external_id }
  end

  private

  def tournament_golfers
    TournamentData.new(league_tournament.external_id).athletes
  end

end
