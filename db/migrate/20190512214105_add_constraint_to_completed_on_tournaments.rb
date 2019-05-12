class AddConstraintToCompletedOnTournaments < ActiveRecord::Migration
  def change
    change_column_default :tournaments, :completed, false
  end
end
