class CreateEntityMapEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entity_map_entries do |t|
      t.integer :key, null: false
      t.json :data
      t.string :type, null: false

      t.timestamps
    end

    add_reference :entity_map_entries, :work, foreign_key: true

    add_index :entity_map_entries, [:key, :work_id], unique: true
  end
end
