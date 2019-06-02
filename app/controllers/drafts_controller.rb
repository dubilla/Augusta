class DraftsController < ApplicationController
  def show
    @draft = Draft.includes(draft_slots: :draft_pick).find(params[:id])
  end
end
