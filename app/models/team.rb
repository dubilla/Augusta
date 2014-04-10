class Team < ActiveRecord::Base

  belongs_to :user, inverse_of: :team

end
