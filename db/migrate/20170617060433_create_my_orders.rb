class CreateMyOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :my_orders do |t|
      t.column :user_id, :integer
      t.column :item, :integer
      t.column :item_id, :integer
      t.column :item_uid, :string
      t.column :item_cat_code, :string
      t.column :quantity, :integer
      t.column :payment_id, :string
      t.timestamps
    end
  end
end
