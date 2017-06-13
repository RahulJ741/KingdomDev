class AddhotelToHotelshopping < ActiveRecord::Migration[5.0]
  def change
    rename_column :hotel_shopping_carts, :room_id, :hotel_id

  end
end
