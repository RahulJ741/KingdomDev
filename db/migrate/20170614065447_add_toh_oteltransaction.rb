class AddTohOteltransaction < ActiveRecord::Migration[5.0]
  def change
  	add_column :hotel_transactions, :room_unique_id, :string
  	add_column :hotel_transactions, :room_type, :string
  end
end
