class CreateWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :works do |t|
      t.string :edition
      t.string :english_title
      t.string :filename
      t.string :form
      t.string :md5_hash
      t.string :original_title, null: false
      t.string :slug, null: false
      t.string :structure
      t.string :urn

      t.timestamps
    end


    add_reference :works, :author, foreign_key: true
    add_reference :works, :corpus, foreign_key: true
    add_reference :works, :language, foreign_key: true

    add_index :works, :urn, unique: true
  end
end
