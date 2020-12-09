class Api::V1::RosterPlayersController < ApplicationController
  def index
    render jsonapi: RosterPlayer.includes(:roster).where(rosters: { league_tournament_id: params[:league_tournament_id] }).sort_by(&:score),
      include: [:player]
  end
end
