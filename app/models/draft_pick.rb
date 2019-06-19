class DraftPick < ApplicationRecord
  belongs_to :draft_slot
  belongs_to :player
end
