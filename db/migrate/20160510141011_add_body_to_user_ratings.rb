class AddBodyToUserRatings < ActiveRecord::Migration
  def change
    add_column :user_ratings, :body, :text
  end
end
