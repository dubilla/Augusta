class AddConstraintToCompletedOnTournaments < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tournaments, :completed, false
  end
end
