class AddtoeventTransaction < ActiveRecord::Migration[5.0]
  def change
  	add_column :event_transactions, :event_name, :string
  end
end
