class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :user_id, null: false
      t.string :public, null: false, default: 'public'

      t.timestamps null: false
    end

    add_index :goals, :user_id
  end
end
