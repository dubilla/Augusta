class LeaderboardsController < ApplicationController

  def index
    @league_tournament = LeagueTournament.find(params[:league_tournament_id])

    @player_leaders = @league_tournament.roster_players.sort_by{ |p| p.score }

    @team_leaders = @league_tournament.rosters.sort_by{ |r| r.score }

    respond_to do |format|
      format.html
    end
  end

end
