class DraftPicksController < ApplicationController
  def index
    @draft_picks = DraftPick.where(draft_id: params[:draft_id])
    render json: @draft_picks
  end

  private

  def draft_pick_params
    params.require(:draft_id)
  end
end
