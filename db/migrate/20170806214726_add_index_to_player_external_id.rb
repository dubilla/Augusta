class AddIndexToPlayerExternalId < ActiveRecord::Migration
  def change
    add_index :players, :external_id, unique: true
  end
end
