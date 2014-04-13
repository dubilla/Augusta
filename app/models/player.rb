class Player < ActiveRecord::Base

	belongs_to :team, inverse_of: :player
end
