class AddWeightToUsers < ActiveRecord::Migration
  def change
    add_column :users, :weight, :decimal, default: 1.0
  end
end
