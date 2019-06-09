class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name

  def name
    object.user.name
  end
end
