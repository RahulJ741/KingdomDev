class MyHotelTransaction < ActiveRecord::Migration[5.0]
  def change
  	create_table :hotel_transactions do |t|
      t.column :user_id, :integer, :null => false
      t.column :hotel_id, :integer
      t.column :from_date, :datetime
      t.column :to_date, :datetime
      t.column :rate, :float
      t.timestamps
    end
  end
end
