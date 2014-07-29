class AddWinnerToRosterPlayer < ActiveRecord::Migration
  def change
  	add_column :roster_players, :winner, :boolean
  end
end
