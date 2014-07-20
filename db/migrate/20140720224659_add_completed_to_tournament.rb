class AddCompletedToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :completed, :boolean
  end
end
