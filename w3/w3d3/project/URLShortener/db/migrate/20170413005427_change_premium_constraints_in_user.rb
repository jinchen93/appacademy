class ChangePremiumConstraintsInUser < ActiveRecord::Migration[5.0]
  def change
    change_column_null :users, :premium, false
  end
end
