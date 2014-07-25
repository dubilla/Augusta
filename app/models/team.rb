class Team < ActiveRecord::Base

  belongs_to :user, inverse_of: :team
  belongs_to :league, inverse_of: :teams
  has_many :rosters, inverse_of: :team

end
