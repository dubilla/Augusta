class SerializableRosterPlayer < JSONAPI::Serializable::Resource
  type 'roster_players'
  attributes :name, :user_name, :score, :status
end
