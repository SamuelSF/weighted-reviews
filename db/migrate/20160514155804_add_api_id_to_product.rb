class AddApiIdToProduct < ActiveRecord::Migration
  def change
    add_column :products, :api_id, :integer
  end
end
