class EnvtModification1 < ActiveRecord::Migration[5.0]
  def change
  	change_column :event_shopping_carts, :rate, :float
  end
end
