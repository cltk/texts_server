class CreateTextNodes < ActiveRecord::Migration[5.1]
  def change
    create_table :text_nodes do |t|
      t.integer :index, null: false
      t.integer :location, array: true, default: [], null: false
      t.json :data
      t.json :entity_ranges, array: true, default: [], null: false
      t.json :inline_style_ranges, array: true, default: [], null: false
      t.string :text_node_type, default: 'unstyled', null: false
      t.string :key, null: false
      t.text :text

      t.timestamps
    end

    add_reference :text_nodes, :author, foreign_key: true
    add_reference :text_nodes, :corpus, foreign_key: true
    add_reference :text_nodes, :language, foreign_key: true
    add_reference :text_nodes, :work, foreign_key: true

    add_index :text_nodes, [:key, :work_id], unique: true
  end
end
