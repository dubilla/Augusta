class Tournament < ActiveRecord::Base

  has_paper_trail

  has_many :league_tournaments

  scope :completed, -> { where completed: true }
  scope :incomplete, -> { !completed }
  scope :active, -> { where(completed: false).where('start_date <= ?', Date.current) }

  def status
    @status ||= TournamentDataFetcher.new(external_id, completed).status
  end
end
