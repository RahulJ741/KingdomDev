class AddUniqueIdToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :unique_id, :string
  end
end
