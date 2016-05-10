class ChangeWeightInUser < ActiveRecord::Migration
  def change
    change_column_default :users, :weight, 5.0
  end
end
