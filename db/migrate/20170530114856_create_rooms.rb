class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.column :name, :string, :null => false
      t.column :description, :string
      t.column :hotel_id, :integer
      t.column :details, :string
      t.column :type, :string
      t.column :size, :integer
      t.column :layout, :string
      t.column :breakfast, :string
      t.column :max_occupancy, :integer

      t.timestamps
    end
  end
end
