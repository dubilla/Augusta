class TeamDecorator < Draper::Decorator

  delegate_all

  def team_wins
    rosters.where(winner: true).count
  end

  def individual_wins
    rosters.collect(&:roster_players).flatten.select(&:winner).count
  end

end
