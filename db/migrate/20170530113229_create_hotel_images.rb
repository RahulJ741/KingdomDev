class CreateHotelImages < ActiveRecord::Migration[5.0]
  def change
    create_table :hotel_images do |t|
      t.column :hotel_id, :integer, :null => false
      t.attachment :pics

      t.timestamps
    end
  end
end
