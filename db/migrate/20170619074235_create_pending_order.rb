class CreatePendingOrder < ActiveRecord::Migration[5.0]
  def change
    create_table :pending_orders do |t|
      t.column :user_id, :integer
      t.column :item, :integer
      t.column :item_id, :integer
      t.column :item_uid, :string
      t.column :item_cat_code, :string
      t.column :quantity, :integer
      t.column :order_id, :integer
      t.timestamps
    end
  end
end
