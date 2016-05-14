class AddThumbImgToProduct < ActiveRecord::Migration
  def change
    add_column :products, :thumb_img, :string
  end
end
