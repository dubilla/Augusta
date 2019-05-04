class RosterPlayer < ActiveRecord::Base

  has_paper_trail

  belongs_to :roster
  belongs_to :player

  delegate :external_id, to: :player
  delegate :name, to: :player
  delegate :league_tournament, to: :roster
  delegate :team, to: :roster
  delegate :user, to: :team
  delegate :name, to: :user, prefix: true

  scope :winner, -> { where winner: true }

  def score
    if tournament_athlete.present?
      tournament_athlete["score"].to_i
    else
      0
    end
  end

  def status
    @status ||= RosterPlayerStatus.new(league_tournament.external_id, external_id, league_tournament.completed).status
  end

  private

  def tournament_athlete
    @tournament_athlete ||= TournamentAthleteFetcher.new(league_tournament.external_id, external_id, league_tournament.completed).tournament_athlete
  end
end
