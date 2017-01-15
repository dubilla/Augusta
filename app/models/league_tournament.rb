class LeagueTournament < ActiveRecord::Base

  has_paper_trail

  belongs_to :league
  belongs_to :tournament
  has_many :rosters

  delegate :external_id, to: :tournament
  delegate :start_date, to: :tournament
  delegate :completed, to: :tournament

  def roster_players
    rosters.collect(&:roster_players).flatten
  end

end
