class AddRatingNumToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :rating_num, :integer, default: 0
  end
end
