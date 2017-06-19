class EditMyOrder2 < ActiveRecord::Migration[5.0]
  def change
  	change_column :my_payments, :payment_id,:string
  end
end
