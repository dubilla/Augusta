class Team < ActiveRecord::Base

  belongs_to :user, inverse_of: :team
  has_many :rosters, inverse_of: :team

end
