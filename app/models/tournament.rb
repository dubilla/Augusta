class Tournament < ApplicationRecord

  has_paper_trail

  has_many :league_tournaments

  scope :completed, -> { where completed: true }
  scope :incomplete, -> { !completed }
  scope :active, -> { where(completed: false).where('start_date <= ?', Date.current) }

  # Ransack 4 allowlist for ActiveAdmin filtering/sorting.
  def self.ransackable_attributes(_auth_object = nil)
    %w[id name start_date external_id completed created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[league_tournaments]
  end

  def status
    @status ||= TournamentDataFetcher.new(external_id, completed).status
  end
end
