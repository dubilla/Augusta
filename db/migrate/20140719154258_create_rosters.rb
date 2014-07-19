class CreateRosters < ActiveRecord::Migration
  def change
    create_table :rosters do |t|
      t.belongs_to :tournament
      t.belongs_to :team
      t.timestamps
    end
  end
end
