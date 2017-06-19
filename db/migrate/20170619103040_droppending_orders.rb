class DroppendingOrders < ActiveRecord::Migration[5.0]
  def change
    drop_table :pending_orders
  end
end
