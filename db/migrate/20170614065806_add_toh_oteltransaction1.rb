class AddTohOteltransaction1 < ActiveRecord::Migration[5.0]
  def change
  	add_column :hotel_transactions, :status, :string

  end
end
