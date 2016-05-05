class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :product_id
      t.text :body
      t.integer :review_score

      t.timestamps null: false
    end
  end
end
