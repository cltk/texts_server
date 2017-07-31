class CreateWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :works do |t|
      t.string :edition
      t.string :englishtitle
      t.string :filename
      t.string :form
      t.string :hash
      t.string :originaltitle, null: false
      t.string :slug, null: false
      t.string :structure

      t.timestamps
    end

    add_reference :text_nodes, :work, foreign_key: true
    add_reference :works, :author, foreign_key: true
    add_reference :works, :corpus, foreign_key: true
    add_reference :works, :language, foreign_key: true

    add_index :text_nodes, [:key, :work_id], unique: true
  end
end
