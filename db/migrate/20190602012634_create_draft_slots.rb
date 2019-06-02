class CreateDraftSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :draft_slots do |t|
      t.references :draft, foreign_key: true
      t.references :team, foreign_key: true
      t.integer :order
      t.timestamps
    end
    remove_column :draft_picks, :draft_id, :integer, foreign_key: true
  end
end
