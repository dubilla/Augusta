class AddFinalScoreToRosterPlayer < ActiveRecord::Migration
  def change
    add_column :roster_players, :final_score, :integer, index: true
  end
end
