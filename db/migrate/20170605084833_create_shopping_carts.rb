class CreateShoppingCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :shopping_carts do |t|
      t.column :user_id, :integer, :null => false
      t.column :room_id, :integer
      t.column :from_date, :datetime
      t.column :to_date, :datetime
      t.column :rate, :integer
      t.timestamps
    end
  end
end
