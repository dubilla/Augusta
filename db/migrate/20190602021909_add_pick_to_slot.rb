class AddPickToSlot < ActiveRecord::Migration[5.2]
  def change
    add_reference :draft_picks, :draft_slot, foreign_key: true
  end
end
