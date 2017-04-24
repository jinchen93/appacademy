class AddUniqueToUserIdInSubsTable < ActiveRecord::Migration[5.0]
  def change
    change_column_null :subs, :user_id, false
  end
end
