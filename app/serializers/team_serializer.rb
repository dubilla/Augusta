class TeamSerializer < ActiveModel::Serializer
  attributes :name

  def name
    object.user.name
  end
end
