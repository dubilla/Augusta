class CreateLeagueTournaments < ActiveRecord::Migration
  def change
    create_table :league_tournaments do |t|
      t.integer :league_id
      t.integer :tournament_id
      t.timestamps
    end
  end
end
