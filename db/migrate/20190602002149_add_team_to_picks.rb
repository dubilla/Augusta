class AddTeamToPicks < ActiveRecord::Migration[5.2]
  def change
    add_reference :draft_picks, :team, foreign_key: true
  end
end
