class AddDefaultOnRosterWinner < ActiveRecord::Migration[5.2]
  def change
    change_column_default :rosters, :winner, false
  end
end
