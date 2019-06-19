class DraftSlotSerializer < ActiveModel::Serializer
  attributes :id, :order

  belongs_to :team
  has_one :draft_pick
end
