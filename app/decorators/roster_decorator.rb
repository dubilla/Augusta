class RosterDecorator < Draper::Decorator

  delegate_all

  def to_json
    {
      id: self.id,
      name: roster.team.user.name,
      score: roster.score
    }
  end
end
