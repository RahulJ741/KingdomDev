class AddUniqueIdToRoom < ActiveRecord::Migration[5.0]
  def change
    add_column :hotel_shopping_carts, :room_unique_id, :string
  end
end
