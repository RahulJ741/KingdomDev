class EditROom < ActiveRecord::Migration[5.0]
  def change
  	rename_table :rooms, :rooms_old
    create_table :rooms do |t|
      t.column :hotel_id, :integer
      t.column :room_type, :string
      t.column :room_code, :string
      t.column :check_in_date, :date
      t.column :check_out_date, :date
      t.column :max_person, :integer
      t.column :no_of_night, :integer
      t.column :rate, :float
    end
  end
end
