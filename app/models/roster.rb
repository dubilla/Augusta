class Roster < ActiveRecord::Base

  has_many :roster_players
  has_many :players, through: :roster_players
  belongs_to :team
  belongs_to :tournament

end
