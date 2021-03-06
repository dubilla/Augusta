class League < ApplicationRecord

  has_paper_trail

  has_many :league_tournaments
  has_many :tournaments, through: :league_tournaments
  has_many :teams, inverse_of: :league

  def active_league_tournament
    league_tournaments.active.first
  end
end
