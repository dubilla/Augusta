class SerializableRoster < JSONAPI::Serializable::Resource
  type 'roster'
  attributes :score

  attribute :name do
    @object.team.user.name
  end
end
