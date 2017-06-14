class AddTOtransaction < ActiveRecord::Migration[5.0]
  def change
  	add_column :hotel_transactions, :pay_id, :string
  	add_column :event_transactions, :pay_id, :string
  end
end
