class Tournament < ActiveRecord::Base

  has_paper_trail

  has_many :league_tournaments

  scope :completed, -> { where completed: true }
  scope :incomplete, -> { !completed }

end
