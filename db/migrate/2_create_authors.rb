class CreateAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :authors do |t|
      t.string :name, null: false
      t.string :slug, null: false

      t.timestamps
    end

    add_reference :authors, :language, foreign_key: true
  end
end
