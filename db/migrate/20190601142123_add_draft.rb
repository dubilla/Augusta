class AddDraft < ActiveRecord::Migration[5.2]
  def change
    add_column :drafts, :starts_at, :datetime
    add_column :drafts, :completed_at, :datetime
  end
end
