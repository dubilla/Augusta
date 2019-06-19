class RemoveTeamOnDraftPicks < ActiveRecord::Migration[5.2]
  def change
    remove_reference :draft_picks, :team
  end
end
