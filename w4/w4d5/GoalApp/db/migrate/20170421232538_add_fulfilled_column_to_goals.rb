class AddFulfilledColumnToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :fulfilled, :string, null: false, default: 'no'
    add_index :goals, :fulfilled
  end
end
