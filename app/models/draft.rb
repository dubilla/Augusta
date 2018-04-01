class Draft < ActiveRecord::Base
  belongs_to :league_tournament
  has_many :draft_picks
end
