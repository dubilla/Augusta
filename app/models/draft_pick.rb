class DraftPick < ApplicationRecord
  belongs_to :slot
  belongs_to :player
  belongs_to :team
end
