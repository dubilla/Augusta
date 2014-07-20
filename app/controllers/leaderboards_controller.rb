class LeaderboardsController < ApplicationController

  def index
    @league_tournament = LeagueTournament.find(params[:league_tournament_id])
    @tournament ||= TournamentData.new(@league_tournament.external_id).event
    league_tournament_players = @league_tournament.rosters.collect(&:players).flatten
    player_ids = league_tournament_players.collect(&:external_id)

    all_competitors = @tournament["competitors"]
    @player_leaders = all_competitors.select{|g| player_ids.include? g["athlete"]["id"] }

    @player_leaders = @league_tournament.roster_players.sort_by{|r| r.score }

    respond_to do |format|
      format.html
    end
  end

end
