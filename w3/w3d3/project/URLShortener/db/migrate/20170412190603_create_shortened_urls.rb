class CreateShortenedUrls < ActiveRecord::Migration[5.0]
  def change
    create_table :shortened_urls do |t|
      t.string :long_url, null: false
      t.string :short_url, null: false
      t.integer :submitter_id, null: false
      t.timestamps null: false
    end

    add_index(:shortened_urls, [:long_url, :short_url], unique: true)
  end
end
