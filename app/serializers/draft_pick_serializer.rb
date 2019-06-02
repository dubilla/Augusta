class DraftPickSerializer < ActiveModel::Serializer
  belongs_to :team
  belongs_to :player
end
