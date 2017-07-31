class CreateLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :languages do |t|
      t.string :slug, null: false
      t.string :title, null: false

      t.timestamps
    end

    add_index :languages, :slug, unique: true
  end
end
