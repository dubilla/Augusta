class DraftPicksController < ApplicationController
  def index
    @draft_picks = DraftPick.where(draft_id: params[:draft_id])
    render json: @draft_picks
  end

  def create
    @draft_pick = DraftPick.new(create_params)
    if @draft_pick.save
      render json: @draft_pick, include: ["player"]
    else
      render json: { errors: @draft_pick.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:draft_pick).permit(:player_id, :draft_slot_id)
  end
end
