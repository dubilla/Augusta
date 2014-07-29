class AddWinnerToRoster < ActiveRecord::Migration
  def change
  	add_column :rosters, :winner, :boolean
  end
end
