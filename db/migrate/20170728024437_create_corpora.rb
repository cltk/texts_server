class CreateCorpora < ActiveRecord::Migration[5.1]
  def change
    create_table :corpora do |t|
      t.string :language, null: false
      t.string :link
      t.string :slug, null: false
      t.string :title, null: false

      t.timestamps
    end

    add_index :corpora, :slug, unique: true
  end
end
