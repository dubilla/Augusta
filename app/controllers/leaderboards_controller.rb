class LeaderboardsController < ApplicationController

  def index
    @league_tournament = LeagueTournament.includes(:league).find(params[:league_tournament_id])

    @player_leaders = @league_tournament.roster_players.map{ |p| p.decorate.to_json }.sort_by{ |p| p[:score] }

    @team_leaders = @league_tournament.rosters.map{ |r| r.decorate.to_json }.sort_by{ |r| r[:score] }

    respond_to do |format|
      format.html
      format.json { render json: { players: @player_leaders, teams: @team_leaders } }
    end
  end
end
