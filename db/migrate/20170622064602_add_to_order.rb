class AddToOrder < ActiveRecord::Migration[5.0]
  def change
  	add_column :my_orders, :rate, :float
  end
end
