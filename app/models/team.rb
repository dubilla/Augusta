class Team < ActiveRecord::Base

  belongs_to :user, inverse_of: :team
  has_many :players, inverse_of: :team

end
