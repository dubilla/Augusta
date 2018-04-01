class CreateDraftPicks < ActiveRecord::Migration
  def change
    create_table :draft_picks do |t|
      t.belongs_to :draft, index: true, foreign_key: true, null: false
      t.belongs_to :player, index: true, foreign_key: true, null: false
      t.timestamps
    end
  end
end
