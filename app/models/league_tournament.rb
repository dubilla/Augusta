class LeagueTournament < ActiveRecord::Base

  belongs_to :league
  belongs_to :tournament
  has_many :rosters

  delegate :external_id, to: :tournament

end
