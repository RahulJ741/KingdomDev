class EditMyOrder3 < ActiveRecord::Migration[5.0]
  def change
  	remove_column :my_orders, :order_id
  end
end
