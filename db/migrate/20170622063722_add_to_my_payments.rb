class AddToMyPayments < ActiveRecord::Migration[5.0]
  def change
  	add_column :my_payments, :freight, :float
  	add_column :my_payments, :cc_amount, :float
  end
end
