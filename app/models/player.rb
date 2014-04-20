class Player < ActiveRecord::Base

	belongs_to :team, inverse_of: :players

  validates :external_id, uniqueness: true

end
