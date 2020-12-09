class Api::V1::RostersController < ApplicationController
  def index
    render jsonapi: Roster.where(league_tournament_id: params[:league_tournament_id]).sort_by(&:score),
      include: [:team]
  end
end
