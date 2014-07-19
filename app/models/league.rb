class League < ActiveRecord::Base

  has_many :league_tournaments
  has_many :tournaments, through: :league_tournaments

end
