class AddMedImgToProduct < ActiveRecord::Migration
  def change
    add_column :products, :med_img, :string
  end
end
