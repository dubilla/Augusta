class Team < ApplicationRecord

  has_paper_trail

  belongs_to :user, inverse_of: :team
  belongs_to :league, inverse_of: :teams
  has_many :rosters, inverse_of: :team
  delegate :name, to: :user

  def team_wins
    rosters.where(winner: true).count
  end

  def individual_wins
    rosters.collect(&:roster_players).flatten.select(&:winner).count
  end

end
