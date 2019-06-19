class DraftSlotsController < ApplicationController
  def index
    @draft_slots = DraftSlot.where(draft_id: draft_slot_params[:draft_id]).order(:order)
    render json: @draft_slots, include: ["team,draft_pick.player"]
  end

  private

  def draft_slot_params
    params.require(:draft_id)
    params
  end
end
