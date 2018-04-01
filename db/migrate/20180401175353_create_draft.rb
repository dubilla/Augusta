class CreateDraft < ActiveRecord::Migration
  def change
    create_table :drafts do |t|
      t.belongs_to :league_tournament
      t.timestamps
    end
  end
end
