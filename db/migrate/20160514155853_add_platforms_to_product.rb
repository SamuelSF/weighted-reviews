class AddPlatformsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :platforms, :string
  end
end
