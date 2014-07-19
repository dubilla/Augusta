class LeagueTournamentsController < ApplicationController

  def show
    @league_tournament = LeagueTournament.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

end
