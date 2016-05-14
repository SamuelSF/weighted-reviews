class AddOriginalReleaseDateToProduct < ActiveRecord::Migration
  def change
    add_column :products, :original_release_date, :date
  end
end
