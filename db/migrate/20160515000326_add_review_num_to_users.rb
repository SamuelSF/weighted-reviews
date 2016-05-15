class AddReviewNumToUsers < ActiveRecord::Migration
  def change
    add_column :users, :review_num, :integer, default: 0
  end
end
