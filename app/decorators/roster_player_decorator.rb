class RosterPlayerDecorator < Draper::Decorator

  delegate_all

  def to_json
    {
      id: self.id,
      name: self.name,
      user_name: self.roster.team.user.name,
      score: self.score
    }
  end

end
