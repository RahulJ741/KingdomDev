class EditMyOrder < ActiveRecord::Migration[5.0]
  remove_column :my_payments, :payment_id
  add_column :my_payments, :order_id, :integer
  def change
  	add_column :my_orders, :order_id, :integer
  end
end
