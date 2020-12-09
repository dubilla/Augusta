class LeaderboardsController < ApplicationController

  def index
    @league_tournament = LeagueTournament.includes(:league).find(params[:tournament_id])

    respond_to do |format|
      format.html
    end
  end
end
