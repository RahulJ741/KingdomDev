class EnvtModification < ActiveRecord::Migration[5.0]
  def change
  	add_column :event_shopping_carts, :event_name, :string
  end
end
