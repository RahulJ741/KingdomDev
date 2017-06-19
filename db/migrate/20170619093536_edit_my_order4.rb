class EditMyOrder4 < ActiveRecord::Migration[5.0]
  def change
  	rename_column :my_orders, :my_payments_id,:my_payment_id
  end
end
