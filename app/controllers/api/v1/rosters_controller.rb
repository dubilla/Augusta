class Api::V1::RostersController < ApplicationController
  def index
    rosters = Roster.where(league_tournament_id: params[:league_tournament_id])
    render jsonapi: rosters.sort_by { |roster| [roster.score || Float::INFINITY, roster.id] },
      include: [:team]
  end
end
