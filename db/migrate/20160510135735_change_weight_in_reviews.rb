class ChangeWeightInReviews < ActiveRecord::Migration
  def change
    change_column_default :reviews, :weight, 5.0
  end
end
