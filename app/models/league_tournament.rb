class LeagueTournament < ActiveRecord::Base

  has_paper_trail

  belongs_to :league
  belongs_to :tournament
  has_many :rosters
  has_many :roster_players, through: :rosters

  delegate :external_id, to: :tournament
  delegate :start_date, to: :tournament
  delegate :completed, to: :tournament
  delegate :name, to: :tournament

  scope :active, -> { joins(:tournament).merge(Tournament.active) }

end
