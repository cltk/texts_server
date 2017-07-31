class CreateCorpora < ActiveRecord::Migration[5.1]
  def change
    create_table :corpora do |t|
      t.string :link
      t.string :slug, null: false
      t.string :title, null: false

      t.timestamps
    end

    add_reference :corpora, :language, foreign_key: true
  end
end
