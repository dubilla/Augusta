class AddNullFalseToRosterWinner < ActiveRecord::Migration
  def change
    change_column_null :rosters, :winner, false
  end
end
