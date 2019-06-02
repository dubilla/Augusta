class DraftSlotSerializer < ActiveModel::Serializer
  attributes :order

  belongs_to :team
  has_one :draft_pick
end
