class EditMyOrder1 < ActiveRecord::Migration[5.0]
  def change
  	remove_column :my_orders, :payment_id 
  	add_column :my_orders, :my_payments_id,:integer
  	add_column :my_payments, :payment_id,:integer 
  end
end
