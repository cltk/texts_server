class CreateAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :authors do |t|
      t.string :language, null: false
      t.string :englishname
      t.string :originalname, null: false
      t.string :slug, null: false

      t.timestamps
    end

    add_index :authors, :slug, unique: true
  end
end
