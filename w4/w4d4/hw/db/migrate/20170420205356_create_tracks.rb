class CreateTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :tracks do |t|
      t.string :name, null: false
      t.integer :album_id, null: false
      t.string :category, null: false, default: "regular"
      t.text :lyrics
      t.timestamps null: false
    end
    add_index :tracks, :album_id
  end
end
