class AddWeightToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :weight, :decimal, default: 1.0
  end
end
