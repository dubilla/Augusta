class LeaderboardsController < ApplicationController

  def index
    @league_tournament = LeagueTournament.find(params[:league_tournament_id])
    @tournament ||= TournamentData.new(@league_tournament.external_id).response
    league_tournament_players = @league_tournament.rosters.collect(&:players).flatten
    player_ids = league_tournament_players.collect(&:external_id)

    all_competitors = @tournament["sports"].first["leagues"].first["events"].first["competitions"].first["competitors"]
    @player_leaders = all_competitors.select{|g| player_ids.include? g["athlete"]["id"] }

    respond_to do |format|
      format.html
    end
  end

end
