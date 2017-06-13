class CartModification < ActiveRecord::Migration[5.0]
  def change
  	rename_table :shopping_carts, :hotel_shopping_carts
  	create_table :event_shopping_carts do |t|
      t.column :user_id, :integer, :null => false
      t.column :event_id, :string
      t.column :event_cat, :string
      t.column :event_date, :datetime
      t.column :rate, :integer
      t.timestamps
    end
  end
end
