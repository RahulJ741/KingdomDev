class CreateShoppingCarts < ActiveRecord::Migration[5.0]
  def change
    change_column :hotel_shopping_carts, :rate, :float
    create_table :hotel_transactions do |t|
      t.column :user_id, :integer, :null => false
      t.column :hotel_id, :integer
      t.column :from_date, :datetime
      t.column :to_date, :datetime
      t.column :rate, :float
      t.column :status, :string
      t.column :room_unique_id, :string
      t.timestamps
    end
  end
end
