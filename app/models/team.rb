class Team < ApplicationRecord

  has_paper_trail

  belongs_to :user, inverse_of: :team
  belongs_to :league, inverse_of: :teams
  has_many :rosters, inverse_of: :team
  delegate :name, to: :user

  # Ransack 4 allowlist for ActiveAdmin filtering/sorting.
  def self.ransackable_attributes(_auth_object = nil)
    %w[id user_id league_id created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user league rosters]
  end

  def team_wins
    rosters.where(winner: true).count
  end

  def individual_wins
    rosters.collect(&:roster_players).flatten.select(&:winner).count
  end

end
