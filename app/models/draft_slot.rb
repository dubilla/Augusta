class DraftSlot < ApplicationRecord
  belongs_to :draft
  belongs_to :team
  has_one :draft_pick
end
