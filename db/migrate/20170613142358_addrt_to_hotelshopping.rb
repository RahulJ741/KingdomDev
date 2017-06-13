class AddrtToHotelshopping < ActiveRecord::Migration[5.0]
  def change
  	add_column :hotel_shopping_carts, :room_type, :string
  end
end
