class CreateRosterPlayer < ActiveRecord::Migration
  def change
    create_table :roster_players do |t|
      t.integer :roster_id
      t.integer :player_id
      t.timestamps
    end
  end
end
