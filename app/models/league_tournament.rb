class LeagueTournament < ActiveRecord::Base

  belongs_to :league
  belongs_to :tournament

end
