class RemoveNotNullOnRosterWinner < ActiveRecord::Migration[5.2]
  def change
    change_column_null :rosters, :winner, true
  end
end
