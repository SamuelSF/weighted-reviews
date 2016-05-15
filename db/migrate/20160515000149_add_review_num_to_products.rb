class AddReviewNumToProducts < ActiveRecord::Migration
  def change
    add_column :products, :review_num, :integer, default: 0
  end
end
