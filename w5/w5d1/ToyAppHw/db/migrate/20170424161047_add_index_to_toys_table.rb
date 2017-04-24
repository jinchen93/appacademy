class AddIndexToToysTable < ActiveRecord::Migration
  def change
    add_index :toys, [:name, :toyable_id, :toyable_type], unique: true
  end
end
