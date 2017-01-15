class Team < ActiveRecord::Base

  has_paper_trail

  belongs_to :user, inverse_of: :team
  belongs_to :league, inverse_of: :teams
  has_many :rosters, inverse_of: :team

end
