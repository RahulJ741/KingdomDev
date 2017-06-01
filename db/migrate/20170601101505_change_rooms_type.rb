class ChangeRoomsType < ActiveRecord::Migration[5.0]
  def change
    rename_column :rooms, :type, :rooms_type
    
  end
end
