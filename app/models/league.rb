class League < ActiveRecord::Base

  has_paper_trail

  has_many :league_tournaments
  has_many :tournaments, through: :league_tournaments
  has_many :teams, inverse_of: :league

end
