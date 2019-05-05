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
    thru || "cut"
  end

  private

  def tournament_athlete
    @tournament_athlete ||= TournamentAthleteFetcher.new(league_tournament.external_id, external_id, league_tournament.completed).tournament_athlete
  end

  def tournament_round
    @tournament_round ||= TournamentDataFetcher.new(@tournament_external_id, @completed).round
  end

  def thru
    @thru ||= RosterPlayerThruParser.new(tournament_athlete, tournament_round).thru
  end
end
